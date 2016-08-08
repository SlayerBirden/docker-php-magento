FROM php:7-fpm
MAINTAINER Oleg Kulik <olegkulik1985@gmail.com>

RUN apt-get update \
  && apt-get install -y \
    cron \
    gettext \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

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
COPY assets/php/templates/* /usr/local/etc/php/

RUN envsubst < /usr/local/etc/php/php.ini.template > /usr/local/etc/php/php.ini

WORKDIR /srv/www

CMD ["/usr/local/bin/setup"]
