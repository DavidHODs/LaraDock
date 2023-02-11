FROM ubuntu:latest

FROM php:8.1-apache

# FROM httpd:2.4

RUN apache2 -v


RUN apt-get update -y && apt upgrade -y

RUN sudo apt-get install php8.1 libapache2-mod-php php8.1-dev php8.1-zip php8.1-curl php8.1-mbstring php8.1-mysql php8.1-gd php8.1-xml

WORKDIR /var/www/html

RUN mkdir -p laravel/ 

ADD ./laravel /var/www/html/laravel

ADD laravel.conf /etc/apache2/sites-available/

RUN chown -R www-data:www-data /var/www/html/laravel && \
    chmod -R 775 /var/www/html/laravel/storage

RUN service apache2 start && service apache2 status

RUN php artisan key:generate && php artisan migrate *phpcli

RUN a2dissite 000-default.conf && \
    a2ensite laravel.conf && \
    a2enmod rewrite && \ 
    service apache2 start
# CMD [ "/bin/sh" ]