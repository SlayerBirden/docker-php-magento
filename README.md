# Magento Docker Images

Suitable for Magento projects.

Example run command

    docker run slayerbirden/phpfpm

## About

This is a minimalistic *phpfpm* container which includes all necessary php extensions for Magento 1 and Magento 2 projects and is built on top of lightweight Alpine Linux.

**Extension List**
- bcmath
- gd
- intl
- ioncube loader (for debian images only)
- ldap
- mbstring
- mcrypt
- mysqli
- opcache
- pdo_mysql
- soap
- xdebug
- xsl
- zip

**Additional Packages**
- composer

## PHP Versions

- 5.5.X
- 5.6.30
- 7.0.16
- 7.1.11

## Ioncube

Unfortunately Ioncube loader is not possible to install on an Alpine Linux since it's only distributed in a compiled form (using glibs, while Alpine uses musl).

For that reason there are debian based tags which include ioncube loader.
