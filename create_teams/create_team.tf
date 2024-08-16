# IAM 사용자 생성
resource "aws_iam_user" "team_users" {
  count = var.team_count
  name  = "${var.team_name}-team-${count.index + 1}"
}

# 콘솔 로그인 프로필 생성 (비밀번호 설정)
resource "aws_iam_user_login_profile" "team_users_login" {
  count                   = var.team_count
  user                    = aws_iam_user.team_users[count.index].name
  password_reset_required = true
}

# 기존 IAM 그룹 데이터 소스
data "aws_iam_group" "existing_groups" {
  count      = length(var.existing_groups)
  group_name = var.existing_groups[count.index]
}

# 사용자를 기존 그룹에 추가
resource "aws_iam_user_group_membership" "group_membership" {
  count  = var.team_count
  user   = aws_iam_user.team_users[count.index].name
  groups = [for group in data.aws_iam_group.existing_groups : group.group_name]
}

# IAM 정책 생성 (콘솔 접근 허용)
resource "aws_iam_policy" "console_access" {
  name        = "allow-console-access-${var.team_name}"
  description = "Allow console access for ${var.team_name} team"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:ChangePassword",
          "iam:GetAccountPasswordPolicy",
        ]
        Resource = "*"
      },
    ]
  })
}

# 정책을 사용자에게 연결
resource "aws_iam_user_policy_attachment" "console_access_attachment" {
  count      = var.team_count
  user       = aws_iam_user.team_users[count.index].name
  policy_arn = aws_iam_policy.console_access.arn
}