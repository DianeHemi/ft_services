# [Download image]
FROM alpine:latest


# [Expose ports]
EXPOSE	22 80 443


# [Download packages]
RUN apk update && apk --no-cache add \
	nginx \
	openrc \
	openssh \
	openssl \
	&& rm -rf /var/cache/apk/*


# [Files and permissions]
RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www


# [Configuration SSL certificate]
RUN mkdir ./ssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/O=42/CN=dchampda" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /ssl/nginx-selfsigned.key -out /ssl/nginx-selfsigned.crt


# [Configuration nginx]
COPY nginx.conf /etc/nginx/nginx.conf
COPY setup.sh /tmp
COPY index.html www/
RUN chmod +x /tmp/setup.sh

# [Config]
CMD sh /tmp/setup.sh
