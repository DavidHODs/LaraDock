FROM ubuntu:latest

FROM webdevops/php-apache:latest

RUN sudo apt update && sudo apt upgrade -y && \
    sudo curl -sS https://getcomposer.org/installer | php && \
    sudo mv composer.phar  /usr/local/bin/composer && \
    sudo chmod a+x /usr/local/bin/composer

RUN mkdir -p /LaraDock/ && \
    sudo mv laravel /LaraDock && cd /LaraDock/laravel && \
    composer install && cd ~ 

RUN cd /LaraDock && \
    sudo mv laravel /var/www/html && \
    cd /var/www/html/laravel && \ 
    sudo chown -R www-data:www-data /var/www/html/laravel && \
    sudo chmod -R 775 /var/www/html/laravel/storage

CMD [ "/bin/sh" ]