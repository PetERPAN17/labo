FROM php:8.4-fpm

# 시스템 패키지 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    wget \
    zip \
    unzip \
    vim \
    nano \
    libpq-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev \
    default-libmysqlclient-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    pkg-config \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

# PHP 확장 설치 (기본 확장만)
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    zip \
    bcmath \
    xml \
    curl \
    mbstring

# Composer 설치
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 작업 디렉토리 설정
WORKDIR /var/www/project

# 소스 코드 복사
COPY ./src .

# Laravel 의존성 설치
RUN composer install --no-dev --optimize-autoloader --no-interaction

# 권한 설정
RUN chown -R www-data:www-data /var/www/project && \
    chmod -R 755 /var/www/project && \
    chmod -R 775 /var/www/project/storage && \
    chmod -R 775 /var/www/project/bootstrap/cache

# PHP 설정 파일 복사
COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini

# 엔트리포인트 스크립트 복사
COPY docker/php/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
