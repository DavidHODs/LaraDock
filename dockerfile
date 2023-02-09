FROM ubuntu:latest

FROM webdevops/php-apache:latest

RUN apt update && apt upgrade -y && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar  /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer

RUN mkdir -p /LaraDock/ && \
    mv laravel /LaraDock && cd /LaraDock/laravel && \
    composer install && cd ~ 

RUN cd /LaraDock && \
    mv laravel /var/www/html && \
    cd /var/www/html/laravel && \ 
    chown -R www-data:www-data /var/www/html/laravel && \
    chmod -R 775 /var/www/html/laravel/storage

CMD [ "/bin/sh" ]