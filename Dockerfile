FROM php:7.0.11-fpm
MAINTAINER Gordon Knoppe <gknoppe@magento.com>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxslt1-dev

RUN docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
        bcmath \
        gd \
        intl \
        mbstring \
        mcrypt \
        opcache \
        pdo_mysql \
        xsl \
        zip \
        soap

RUN pecl install xdebug-2.4.1

RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN echo "memory_limit=2048M" > /usr/local/etc/php/conf.d/magento.ini \
    && echo "realpath_cache_size=2M" >> /usr/local/etc/php/conf.d/magento.ini \
    && echo "opcache.max_accelerated_files=200000" >> /usr/local/etc/php/conf.d/magento.ini \
    && echo "opcache.memory_consumption=256M" >> /usr/local/etc/php/conf.d/magento.ini \
    && echo "zlib.output_compression=1" >> /usr/local/etc/php/conf.d/magento.ini
