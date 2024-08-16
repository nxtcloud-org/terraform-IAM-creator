output "iam_user_details" {
  value = [
    for i, user in aws_iam_user.team_users : {
      username = user.name
      arn      = user.arn
    }
  ]
  sensitive   = true
  description = "생성된 팀계정 상세정보"
}

output "user_group_memberships" {
  value = {
    for user in aws_iam_user.team_users : user.name => aws_iam_user_group_membership.group_membership[index(aws_iam_user.team_users, user)].groups
  }
  description = "생성된 팀계정이 소속된 그룹"
}