FROM php:8.1-apache

RUN apt-get update -y && apt install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/laravel

WORKDIR /var/www/html/laravel

ADD ./laravel /var/www/html/laravel
ADD laravel.conf /etc/apache2/sites-available/

ENV MYSQL_HOST mysql
ENV MYSQL_USERNAME root
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE laraveldb

RUN chown -R www-data:www-data /var/www/html/laravel && \
    chmod -R 775 /var/www/html/laravel/storage && \
    php artisan key:generate && \
    a2dissite 000-default.conf && \
    a2ensite laravel.conf && \
    a2enmod rewrite && \ 
    service apache2 start