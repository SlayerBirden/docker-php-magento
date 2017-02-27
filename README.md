# Docker Image

Suitable for Magento projects.

Example run command

    docker run slayerbirden/magento-phpfpm

## About

This is a minimalistic phpfpm container which includes all necessary php extensions for Magento 1 and Magento 2 projects and built on top of lightweight Alpine Linux.

Additionally it includes LDAP extension to work with LDAP-based services and XDebug for testing. Composer is also installed.

## PHP Versions
Current releases are pulled from docker php library images: php:7-fpm-alpine and php:5-fpm-alpine.

If you need any specific PHP version please modify Dockerfile to pull from other php image version.
