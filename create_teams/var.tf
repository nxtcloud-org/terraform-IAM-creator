variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "team_count" {
  description = "팀 수에 맞게 설정"
  type        = number
  default     = 10
}

variable "existing_groups" {
  description = "생성된 팀 계정이 속해야하는 기존 IAM GROUP 리스트"
  type        = list(string)
  default     = ["dsc", "CICD"]
}

variable "team_name" {
  description = "대학 또는 해커톤 타이틀"
  type        = string
  default     = "dsc"
}