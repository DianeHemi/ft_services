# [Download image]
FROM alpine:3.12

# [Download packages]
RUN apk update && apk add --no-cache nginx openrc openssl wget php7 php7-bcmath php7-common php7-ctype php7-curl php7-fpm php7-gd php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-mysqlnd php7-mysqli php7-opcache php7-openssl php7-pdo php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite php7-phar php7-posix php7-session php7-soap php7-xml php7-zlib php7-zip \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& rm -rf /var/cache/apk/* \
	&& mkdir /www


# [Files and permissions]
COPY telegraf.conf /etc/

# [Configuration SSL certificate]
RUN mkdir ./ssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/O=42/CN=dchampda" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /ssl/nginx-selfsigned.key -out /ssl/nginx-selfsigned.crt


# [Configuration nginx]
COPY nginx.conf /etc/nginx
COPY setup.sh /tmp
RUN mkdir /var/run/nginx \
	&& chmod +x /tmp/setup.sh

# [Configuration phpmyadmin]
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.4-all-languages phpmyadmin \
	&& mv phpmyadmin /www \
	&& rm -f /www/phpmyadmin/config.sample.inc.php \
	&& rm -f phpMyAdmin-5.0.4-all-languages.tar.gz
COPY config.inc.php /www/phpmyadmin


# [Config]
CMD sh /tmp/setup.sh

EXPOSE 5000