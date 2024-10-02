#!/bin/bash

# 애플리케이션 디렉토리 생성 (없는 경우)
mkdir -p /home/ec2-user/nextcicdtest

# 애플리케이션 디렉토리로 이동
cd /home/ec2-user/nextcicdtest

# 저장소가 없으면 클론, 있으면 풀
if [ ! -d ".git" ]; then
    git clone https://github.com/yoonseopkim/nextcicdtest.git .
else
    git pull origin main
fi

# 의존성 설치
npm install

# 프로젝트 빌드
npm run build

# PM2로 애플리케이션 재시작
pm2 restart nextjs-app || pm2 start npm --name "nextjs-app" -- start