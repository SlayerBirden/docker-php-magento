FROM php:7-fpm-alpine
MAINTAINER Oleg Kulik <olegkulik1985@gmail.com>

RUN docker-php-ext-install \
    gd \
    intl \
    mbstring \
    mcrypt \
    pdo_mysql \
    soap \
    xsl \
    zip \
    bcmath \
    # Install composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && echo $'memory_limit = $PHP_MEMORY_LIMIT\n\
max_execution_time = $PHP_MAX_EXEC_TIME\n\
max_input_time = $PHP_MAX_INPUT_TIME' > /usr/local/etc/php/php.ini.tmpl

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_MAX_EXEC_TIME 1800
ENV PHP_MAX_INPUT_TIME 1800

RUN apk add \
    --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    --virtual .shadow-deps \
    shadow \
    && apk add --update --virtual .gettext-deps \
    gettext \
    # We want to leave gettext for the later use
    && envsubst < /usr/local/etc/php/php.ini.tmpl > /usr/local/etc/php/php.ini \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && apk del .shadow-deps

COPY bin/* /usr/local/bin/

WORKDIR /srv/www

CMD ["/usr/local/bin/setup"]
