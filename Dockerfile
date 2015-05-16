FROM debian:jessie
MAINTAINER Mizunashi Mana <mizunashi_mana@mma.club.uec.ac.jp>

# Installing packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install tar curl supervisor

# Installing nginx
RUN apt-get -y install nginx

# Installing PHP
RUN apt-get -y install php5-fpm php5-gd

# Package clean
RUN apt-get clean && apt-get -y autoremove

# Init
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "expose_php = Off" >> /etc/php5/fpm/php.ini
ADD supervisor-config/ /etc/supervisor/conf.d

# Installing Dockuwiki
RUN mkdir -p /var/www/dokuwiki/
RUN cd /var/www/dokuwiki/ && curl http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | tar xz --strip 1
RUN chown -R www-data:www-data /var/www
RUN rm /etc/nginx/sites-enabled/*
ADD nginx-config/dokuwiki-site /etc/nginx/sites-enabled/

# Please, execute `docker exec wiki_container after_install` after dokuwiki installed
COPY after_install.sh /bin/after_install
RUN chmod +x /bin/after_install

# EXPOSE 80 443
VOLUME ["/var/www/dokuwiki/data/", "/var/www/dokuwiki/lib/plugins","/var/www/dokuwiki/conf/","/var/www/dokuwiki/lib/tpl/","/var/log"]

CMD ["/usr/bin/supervisord", "-n"]
