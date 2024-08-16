terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  create_date = formatdate("YYYY-MM-DD", timestamp())
  students    = csvdecode(file(var.csv_file_path))
}

resource "aws_iam_group" "student_group" {
  name = var.school_code
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  count      = length(var.managed_policy_arns)
  group      = aws_iam_group.student_group.name
  policy_arn = var.managed_policy_arns[count.index]
}

resource "aws_iam_user" "students" {
  count = length(local.students)
  name  = "${var.school_code}-${format("%03d", count.index + 1)}"

  tags = {
    Name       = local.students[count.index].name
    University = var.school_full_name
    Email      = local.students[count.index].email
    Number     = local.students[count.index].number
    CreateDate = local.create_date
  }
}

resource "aws_iam_user_login_profile" "student_login" {
  count                   = length(local.students)
  user                    = aws_iam_user.students[count.index].name
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "student_group_membership" {
  count  = length(local.students)
  user   = aws_iam_user.students[count.index].name
  groups = [aws_iam_group.student_group.name]
}

# 사용자 정보를 템플릿에 전달하기 위한 로컬 변수
locals {
  user_details = [
    for i, user in aws_iam_user.students : {
      name     = user.tags.Name
      username = user.name
      password = aws_iam_user_login_profile.student_login[i].password
    }
  ]
}

# 템플릿 파일을 사용하여 결과 파일 생성
resource "local_file" "user_info" {
  filename = var.result_file_name
  content  = templatefile("${path.module}/students_detail.tpl", { users = local.user_details })
}

# 비밀번호 정보를 포함한 파일에 대한 권한 설정
resource "local_file" "user_info_permissions" {
  filename        = var.result_file_name
  content         = local_file.user_info.content
}