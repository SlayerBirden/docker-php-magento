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
  bcmath

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_MAX_EXEC_TIME 1800
ENV PHP_MAX_INPUT_TIME 1800

COPY bin/* /usr/local/bin/

RUN echo $'memory_limit = $PHP_MEMORY_LIMIT\n\
max_execution_time = $PHP_MAX_EXEC_TIME\n\
max_input_time = $PHP_MAX_INPUT_TIME' > /usr/local/etc/php/php.ini.tmpl

RUN apk add --update --virtual .build-deps \
    gettext && \
    envsubst < /usr/local/etc/php/php.ini.tmpl > /usr/local/etc/php/php.ini && \
    apk del .build-deps

WORKDIR /srv/www

CMD ["/usr/local/bin/setup"]
