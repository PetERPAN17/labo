#!/bin/bash

set -e

echo "Starting Laravel application setup..."

# 환경 파일 확인 및 생성
if [ ! -f /var/www/project/.env ]; then
    echo "Creating .env file..."
    if [ -f /var/www/project/.env.example ]; then
        cp /var/www/project/.env.example /var/www/project/.env
    else
        echo "Warning: .env.example not found"
    fi
fi

# 애플리케이션 키 생성
echo "Generating application key..."
php artisan key:generate --force || true

# 데이터베이스 마이그레이션
echo "Running database migrations..."
php artisan migrate --force || true

# 캐시 초기화
echo "Clearing caches..."
php artisan cache:clear || true
php artisan config:cache || true
php artisan view:clear || true

# 권한 설정
echo "Setting permissions..."
chown -R www-data:www-data /var/www/project/storage
chmod -R 775 /var/www/project/storage
chown -R www-data:www-data /var/www/project/bootstrap/cache
chmod -R 775 /var/www/project/bootstrap/cache

echo "Laravel application setup completed!"

# PHP-FPM 시작
exec php-fpm
