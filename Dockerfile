FROM debian:10

RUN apt-get update && \
    apt-get install -y apache2 mariadb-server php php-mysqli php-gd libapache2-mod-php
  
COPY dvwa /var/www/html

RUN chown www-data:www-data -R /var/www/html && \
    rm /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["tail", "-f", "/dev/null"]
