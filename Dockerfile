FROM debian:10

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    debconf-utils && \
    echo mariadb-server mysql-server/root_password password p4ssw0rd | debconf-set-selections && \
    echo mariadb-server mysql-server/root_password_again password p4ssw0rd | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \    
    mariadb-server &&\
    apt-get install -y apache2 php php-mysqli php-gd libapache2-mod-php
  
COPY . /var/www/html
COPY php.ini /etc/php/7.3/apache2/php.ini

RUN chown www-data:www-data -R /var/www/html && \
    rm /var/www/html/index.html
    
RUN service mysql start && \
    sleep 3 && \
    mysql -uroot -pp4ssw0rd -e "CREATE USER dvwa@localhost IDENTIFIED BY 'p4ssw0rd';CREATE DATABASE dvwa;GRANT ALL privileges ON dvwa.* TO 'dvwa'@localhost;"

RUN service apache2 start

EXPOSE 80

ENTRYPOINT ["tail", "-f", "/dev/null"]
