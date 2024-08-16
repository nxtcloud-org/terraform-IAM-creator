# [Terraform] IAM-Creator

## 주요 기능

1. CSV 파일에서 학생 정보를 읽어 IAM 사용자 생성
2. 지정된 IAM 그룹 생성 및 사용자 할당
3. 사전 정의된 관리형 정책을 그룹에 연결
4. 각 사용자에 대한 초기 로그인 프로필 생성
5. 생성된 사용자 정보를 Markdown 파일로 출력

## 사전 요구사항

- [Terraform](https://www.terraform.io/downloads.html) (버전 0.12 이상)
- AWS 계정 및 적절한 권한을 가진 IAM 사용자
- AWS CLI가 구성되어 있거나 AWS 자격 증명이 환경 변수로 설정되어 있어야 함

## 사용 방법

1. `students.csv` 파일을 프로젝트 루트 디렉토리에 생성하고 학생 정보를 입력합니다.
   CSV 형식: `name,email,number`
2. `variables.tf` 파일에서 학교코드, 풀네임 지정
3. Terraform 초기화:

   ```
   terraform init
   ```
4. 실행 계획 확인:

   ```
   terraform plan
   ```
5. 리소스 생성:

   ```
   terraform apply
   ```
6. 작업이 완료되면 `result.md` 파일에서 생성된 사용자 정보를 확인할 수 있습니다.

## 변수 설정

`variables.tf` 파일에서 다음 변수들을 설정할 수 있습니다:

- `school_code`: IAM 사용자 이름 앞에 붙는 학교 또는 단체 코드 (기본값: "AAA")
- `school_full_name`: 학교 또는 단체의 전체 이름 (기본값: "00대학교")
- `aws_region`: 리소스를 배포할 AWS 리전 (기본값: "us-east-1")
- `csv_file_path`: 학생 정보가 포함된 CSV 파일의 경로 (기본값: "students.csv")
- `managed_policy_arns`: IAM 그룹에 연결할 관리형 정책 ARN 목록
- `result_file_name`: 사용자 정보를 저장할 파일의 이름 (기본값: "result.md")

## 주의사항

- 생성된 사용자의 초기 비밀번호는 `result.md` 파일에 저장됩니다. 이 파일은 안전하게 관리해야 합니다.
- 사용자들에게 첫 로그인 시 비밀번호를 변경하도록 안내해야 합니다.
