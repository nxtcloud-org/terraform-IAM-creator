Team: ${team_name}
로그인 콘솔주소: https://nxtcloud.signin.aws.amazon.com/console

User Details:
%{ for i, user in users ~}
IAM Username: ${user.name}
초기비밀번호: ${passwords[i].password}

%{ endfor ~}
초기 로그인 후 비밀번호를 재설정하세요
(대소문자, 숫자 조합)