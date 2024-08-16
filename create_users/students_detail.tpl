# IAM 사용자 정보
## 로그인 콘솔주소: https://nxtcloud.signin.aws.amazon.com/console
## 첫 로그인 시 비밀번호를 변경(대소문자+숫자 포함)

| Name | IAM User Name | Password |
|------|---------------|----------|
%{ for user in users ~}
| ${user.name} | ${user.username} | ${user.password} |
%{ endfor ~}

