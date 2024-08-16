# variables.tf

variable "school_code" {
  description = "IAM 유저 이름 앞에 붙는 학교 또는 단체 코드"
  type        = string
  default = "AAA"
}

variable "school_full_name" {
  description = "학교 또는 단체의 전체 이름"
  type        = string
  default = "00대학교"
}

variable "aws_region" {
  description = "리소스를 배포할 AWS 리전"
  type        = string
  default     = "us-east-1"
}

variable "csv_file_path" {
  description = "학생 정보가 포함된 CSV 파일의 경로"
  type        = string
  default     = "students.csv"
}

variable "managed_policy_arns" {
  description = "IAM 그룹에 연결할 관리형 정책 ARN 목록, 제한 리전에 따라서 정책 변경"
  type        = list(string)
  default     = [
    "arn:aws:iam::730335373015:policy/AllowNonOverkill",
    "arn:aws:iam::730335373015:policy/RestrictRegionSeoul",
    "arn:aws:iam::730335373015:policy/IAMBasicAccess",
    "arn:aws:iam::730335373015:policy/SafePowerUser",
    "arn:aws:iam::730335373015:policy/DenyDestruct",
  ]
}

variable "result_file_name" {
  description = "사용자 정보를 저장할 파일의 이름"
  type        = string
  default     = "result.md"
}