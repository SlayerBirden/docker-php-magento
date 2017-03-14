FROM php:5.5-fpm-alpine
MAINTAINER Oleg Kulik <olegkulik1985@gmail.com>

RUN apk add --no-cache --virtual .build-deps \
            # for all
            zlib-dev \
            # dev deps for gd
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
            # for intl
            icu-dev \
            # for mcrypt
            libmcrypt-dev \
            # for soap
            libxml2-dev \
            # for xsl
            libxslt-dev \
            # for ldap
            openldap-dev \
            # to build xdebug from PECL
            $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        ldap \
        mbstring \
        mcrypt \
        mysqli \
        opcache \
        pdo_mysql \
        soap \
        xsl \
        zip \
    && docker-php-ext-enable xdebug \
    # next will add runtime deps for php extensions
    # what this does is checks the necessary packages for php extensions Shared Objects
    # and adds those (won't be removed when .build-deps are)
    && runDeps="$( \
            scanelf --needed --nobanner --recursive \
                /usr/local/lib/php/extensions \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
        )" \
    && apk add --virtual .phpexts-rundeps $runDeps \
    && apk del .build-deps \
    # Install composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'signature');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('signature'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

VOLUME /srv/www
WORKDIR /srv/www

CMD ["php-fpm"]
