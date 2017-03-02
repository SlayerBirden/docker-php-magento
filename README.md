# Docker Image

Suitable for Magento projects.

Example run command

    docker run slayerbirden/phpfpm

## About

This is a minimalistic phpfpm container which includes all necessary php extensions for Magento 1 and Magento 2 projects and built on top of lightweight Alpine Linux.

Additionally it includes LDAP extension to work with LDAP-based services and XDebug for testing. Composer is also installed.

The image is also suitable to run other php applications, for example WordPress.

## PHP Versions
Current releases are pulled from docker php library images: php:7-fpm-alpine and php:5-fpm-alpine.

If you need any specific PHP version please modify Dockerfile to pull from other php image version.

## Ioncube

Unfortunately Ioncube loader is not possible to install on an Alpine Linux since it's only distributed in a compiled form (using glibs, while Alpine uses musl).

For that reason there's **5debian** tag which includes ioncube loader.
