FROM php:7.1-apache
LABEL maintainer="Siva Karuppiah <sivakg2000@gmail.com>"


# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Install PHP extensions
RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    libbz2-dev \
    libjpeg-dev \
    libldap2-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    ; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \
    docker-php-ext-configure ldap --with-libdir="lib/$debMultiarch"; \
    docker-php-ext-install -j "$(nproc)" \
    bz2 \
    gd \
    ldap \
    mcrypt \
    mysqli \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    zip \
    ; \
    \
    # pecl will claim success even if one install fails, so we need to perform each install separately
    pecl install APCu-5.1.17; \
    pecl install memcached-3.1.4; \
    pecl install redis-4.3.0; \
    \
    docker-php-ext-enable \
    apcu \
    memcached \
    redis \
    ; \
    \
    # reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
    | awk '/=>/ { print $3 }' \
    | sort -u \
    | xargs -r dpkg-query -S \
    | cut -d: -f1 \
    | sort -u \
    | xargs -rt apt-mark manual; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html

ENV WORDPRESS_VERSION 5.3

RUN set -ex; \
    curl -o wordpress.tar.gz -SL https://github.com/WordPress/WordPress/archive/${WORDPRESS_VERSION}.tar.gz; \
    mkdir /usr/src/wordpress; \
    tar -xf wordpress.tar.gz -C /usr/src/wordpress; \
    rm wordpress.tar.gz; \
    chown -R www-data:www-data /usr/src/wordpress

COPY docker-entrypoint.sh /entrypoint.sh
COPY makedb.php /makedb.php

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]