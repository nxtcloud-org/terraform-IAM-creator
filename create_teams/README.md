# 해커톤 팀 생성 Terraform

이 프로젝트는 AWS IAM 사용자를 생성하고 관리하기 위한 Terraform 코드를 포함하고 있습니다.
팀 구성원을 위한 IAM 사용자를 자동으로 생성하고, 지정된 그룹에 추가하며, 콘솔 접근 권한을 부여합니다.

## 프로젝트 구조

```
.
├── main.tf           # Terraform 설정 및 프로바이더 구성
├── create_team.tf    # IAM 사용자 및 관련 리소스 생성 로직
├── var.tf            # 변수 정의
├── outputs.tf        # 출력 정의
├── user_details.tpl  # 사용자 상세 정보 템플릿
├── team_user_details.txt  # 생성된 팀 로그인 정보(리소스 생성시 함께 생성됨)
├── terraform-install.sh # Terraform 설치 명령어
└── README.md         # 프로젝트 문서 (현재 파일)
```

## 기능

- 지정된 수의 IAM 사용자 생성
- 사용자를 기존 IAM 그룹에 추가
- 콘솔 접근을 위한 IAM 정책 생성 및 연결
- 사용자 로그인 프로필 생성 (초기 비밀번호 설정)
- 사용자 상세 정보를 파일로 출력(team_user_details.txt)

## 사용 방법

1. 필요 조건:

   - Terraform v0.12 이상
   - AWS CLI가 설치되어 있고 구성되어 있어야 함
2. Terraform 설치(필요시)

   - 실행권한 부여 : `chmod 700 terraform-install.sh`
   - 관리자권한으로 실행 : `sudo ./terraform-install.sh`
   - 설치확인 : `terraform version`
3. 변수 설정:
   `var.tf` 파일을 열고 필요에 따라 기본값을 수정
4. Terraform 초기화:

   ```
   terraform init
   ```
5. 계획 확인:

   ```
   terraform plan
   ```
6. 리소스 생성:

   ```
   terraform apply
   ```
7. 리소스 삭제 (필요시):

   ```
   terraform destroy
   ```

## 주요 변수

- `region`: AWS 리전
- `team_count`: 생성할 팀 멤버 수
- `existing_groups`: 사용자를 추가할 기존 IAM 그룹 목록
- `team_name`: 팀 이름 (사용자 이름 접두사로 사용)

## 출력

- `team_user_details`: 생성된 IAM 사용자의 상세 정보
- `user_group_memberships`: 각 사용자가 속한 그룹 정보

## 주의사항

- IAM 사용자의 초기 비밀번호는 자동으로 생성되며, 사용자는 첫 로그인 시 비밀번호를 변경해야 합니다.
- 기존 IAM 그룹이 존재해야 합니다. 그룹이 없는 경우 오류가 발생할 수 있습니다.
- AWS 계정에 대한 적절한 권한이 있는지 확인하세요.

## 문제 해결

문제가 발생하면 다음을 확인하세요:

1. AWS 자격 증명이 올바르게 설정되어 있는지 확인
2. 지정된 IAM 그룹이 AWS 계정에 존재하는지 확인
3. Terraform 및 AWS CLI 버전이 최신인지 확인
