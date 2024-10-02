# Base image
FROM php:8.3-fpm

# Install required system dependencies
RUN apt update -y && apt dist-upgrade -y && apt-get install -y \
    libicu-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libzip-dev \
    libonig-dev \
    unzip \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install required extensions by Codeigniter
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
    intl \
    mbstring \
    curl \
    gd \
    simplexml \
    dom \
    xml \
    mysqli \
    opcache \
    zip

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose the port PHP-FPM runs on
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

