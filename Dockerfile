FROM php:8.3-apache

WORKDIR /var/www/html

# Install MySQLi extension
RUN docker-php-ext-install mysqli

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy backend files
COPY . /var/www/html/

# Create upload directories
RUN mkdir -p /var/www/html/uploads/payment_screenshots \
    && chown -R www-data:www-data /var/www/html/uploads \
    && chmod -R 775 /var/www/html/uploads

# Copy Apache startup script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make startup script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

# Start Apache through custom entrypoint
CMD ["/usr/local/bin/docker-entrypoint.sh"]