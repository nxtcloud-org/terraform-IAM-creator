#!/bin/bash

# 최신 Terraform 버전 확인
LATEST_VERSION=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].version' | grep -v '-' | grep -v 'beta' | sort -V | tail -1)

# Terraform 다운로드 URL 설정
DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${LATEST_VERSION}/terraform_${LATEST_VERSION}_linux_amd64.zip"

# Terraform 다운로드
curl -O ${DOWNLOAD_URL}

sleep 3

# 압축 해제
unzip terraform_${LATEST_VERSION}_linux_amd64.zip .

# Terraform 바이너리를 /usr/local/bin으로 이동 (관리자 권한 필요)
sudo mv terraform /usr/local/bin/

# 압축 파일 삭제
rm terraform_${LATEST_VERSION}_linux_amd64.zip