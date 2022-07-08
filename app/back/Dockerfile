# FROM php:7.4-apache

# # Arguments defined in docker-compose.yml
# ARG user=composer
# ARG uid=1000

# # Install packages
# RUN apt-get update && apt-get install -y \
#     git \
#     zip \
#     curl \
#     sudo \
#     unzip \
#     libicu-dev \
#     libbz2-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libmcrypt-dev \
#     libreadline-dev \
#     libfreetype6-dev \
#     g++

# # Apache configuration
# ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
# RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
# RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
# RUN a2enmod rewrite headers

# # Common PHP Extensions
# RUN docker-php-ext-install \
#     bz2 \
#     intl \
#     iconv \
#     bcmath \
#     opcache \
#     calendar \
#     pdo_mysql

# # -------------------- Installing PHP Extension: memcached --------------------
# RUN apt-get install -y libmemcached-dev \
#     && pecl install memcached \
#     && docker-php-ext-enable memcached


# # Ensure PHP logs are captured by the container
# ENV LOG_CHANNEL=stderr

# # Set a volume mount point for your code
# VOLUME /var/www/html

# # Copy code and run composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user

# COPY . /var/www/tmp
# RUN cd /var/www/tmp &&  composer update && composer install --no-dev --optimize-autoloader

# RUN chown -R www-data:www-data /var/www

# # Optimizing Configuration loading
# RUN cd /var/www/tmp && php artisan config:cache
# # Optimizing Route loading
# RUN cd /var/www/tmp && php artisan route:cache

# RUN cd /var/www/tmp && php artisan optimize

# EXPOSE 8000

# # Ensure the entrypoint file can be run
# RUN chmod +x /var/www/tmp/docker-entrypoint.sh
# ENTRYPOINT ["/var/www/tmp/docker-entrypoint.sh"]

# USER $user
# # The default apache run command
# CMD ["apache2-foreground"]

# EXPOSE 8000
# CMD [ "php", "artisan", "serve", "--host", "0.0.0.0" ]

# ------------------

FROM php:7.4-fpm

COPY . /myapp
WORKDIR /myapp

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar update

EXPOSE 8000
CMD [ "php", "artisan", "serve", "--host", "0.0.0.0" ]
