FROM php:8.3-apache

WORKDIR /var/www/html

# Install MySQLi extension
RUN docker-php-ext-install mysqli

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod dir

# Copy all backend files
COPY . /var/www/html/

# Set Apache permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Create upload directories
RUN mkdir -p /var/www/html/uploads/payment_screenshots \
    && chown -R www-data:www-data /var/www/html/uploads \
    && chmod -R 775 /var/www/html/uploads

# Make index.php the default page
RUN printf '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    DirectoryIndex index.php\n\
</Directory>\n' > /etc/apache2/conf-available/appkarkhana.conf \
    && a2enconf appkarkhana

# Copy startup script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make startup script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]