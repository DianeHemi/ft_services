# [Download image]
FROM alpine:latest

# [Download packages]
RUN apk update && apk --no-cache add \
	nginx \
	openrc \
	php7 \
	php7-bcmath \
	php7-ctype \
	php7-curl \
	php7-fpm \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-json \
	php7-mbstring \
	php7-mcrypt \
	php7-mysqlnd \
	php7-mysqli \
	php7-opcache \
	php7-openssl \
	php7-pdo \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-phar \
	php7-posix \
	php7-session \
	php7-soap \
	php7-xml \
	php7-zlib \
	php7-zip \
	&& rm -rf /var/cache/apk/*


# [Configuration nginx]
COPY nginx.conf /etc/nginx/conf.d
RUN mkdir /var/run/nginx \
	&& rm -f /etc/nginx/conf.d/default.conf

# [Configuration phpmyadmin]
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& mv  phpMyAdmin-5.0.4-all-languages /www \
	&& rm -f /www/config.sample.inc.php \
	&& rm -f phpMyAdmin-5.0.4-all-languages.tar.gz
COPY config.inc.php /www

# [Configuration au lancement]
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh

# [Config]
CMD sh /tmp/setup.sh

EXPOSE 5000