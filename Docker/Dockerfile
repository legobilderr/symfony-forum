FROM php:8.1.2-apache

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires
RUN service apache2 restart
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmongoc-dev \
        libbson-dev \
        libicu-dev \
        libonig-dev \
        libzip-dev \
        libbz2-dev \
        libxslt1-dev \
        libldb-dev \
        libldap2-dev \
        procps \
        iputils-ping \
        default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure intl --enable-intl \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure mysqli --with-mysqli \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-configure mbstring --enable-mbstring \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install -j$(nproc) \
    gd \
    bcmath \
    intl \
    pcntl \
    mysqli \
    pdo_mysql \
    mbstring \
    iconv \
    bz2 \
    calendar \
    exif \
    gettext \
    shmop \
    sysvmsg \
    sysvsem \
    sysvshm \
    xsl \
    zip \
    ldap \
    && pecl install redis-5.3.3 \
    && docker-php-ext-enable redis

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN set -xe && curl -sS https://getcomposer.org/installer -o composer-setup.php && \
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html
RUN rm -f /docker-entrypoint.sh && rm -f /usr/local/etc/php-fpm.d/*


RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer


WORKDIR /var/www/html

# Apache mime fix
RUN ln -s /etc/mime.types /etc/apache2/mime.types

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod 4755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
CMD ["apache2-foreground"]