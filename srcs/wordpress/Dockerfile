# [Download image]
FROM alpine:3.12


# [Expose ports]
EXPOSE	5050


# [Download packages]
RUN apk update && apk add --no-cache nginx openrc openssl wget php7 php7-bcmath php7-common php7-ctype php7-curl php7-fpm php7-gd php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-mysqlnd php7-mysqli php7-opcache php7-openssl php7-pdo php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite php7-phar php7-posix php7-session php7-soap php7-xml php7-zlib php7-zip \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& rm -rf /var/cache/apk/* \
	&& mkdir /www/


# [Configuration WordPress]
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvzf latest.tar.gz \
	&& mv /wordpress/ /www/ \
	&& rm -f latest.tar.gz \
	&& rm -f /www/wp-config-sample.php
COPY wp-config.php /www/


# [Files and permissions]
RUN adduser -D -g 'www' www \
	&& chown -R www:www /var/lib/nginx
COPY telegraf.conf /etc/

# [Configuration SSL certificate]
RUN mkdir ./ssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/O=42/CN=dchampda" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /ssl/nginx-selfsigned.key -out /ssl/nginx-selfsigned.crt


# [Configuration nginx]
COPY nginx.conf /etc/nginx
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh \
	&& mkdir /run/nginx



# [Config]
CMD sh /tmp/setup.sh