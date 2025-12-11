FROM nginx:1.28-alpine

# nginx 설정 파일 복사
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# 로그 디렉토리 생성
RUN mkdir -p /var/log/nginx && \
    chmod 755 /var/log/nginx

# nginx 실행
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
