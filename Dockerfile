FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    unzip \
    libicu-dev \
    && docker-php-ext-install \
    pdo_mysql \
    intl \
    && apt-get clean

RUN a2enmod rewrite

COPY codeigniter.conf /etc/apache2/sites-available/codeigniter.conf

RUN a2dissite 000-default.conf \
    && a2ensite codeigniter.conf

WORKDIR /var/www/codeigniter
COPY ./ /var/www/codeigniter

RUN chown -R www-data:www-data writable/
RUN chmod -R 777 writable/

EXPOSE 80

CMD ["apache2-foreground"]
