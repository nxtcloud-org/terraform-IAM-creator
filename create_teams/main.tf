terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  region = var.region
}

# 결과 파일 생성
resource "local_file" "team_user_details" {
  filename = "${path.module}/team_user_details.txt"
  content  = templatefile("${path.module}/team_details.tpl", {
    users     = aws_iam_user.team_users
    passwords = aws_iam_user_login_profile.team_users_login
    team_name = var.team_name
  })
}