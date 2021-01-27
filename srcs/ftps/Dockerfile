# [Download image]
FROM alpine:3.12


# [Expose ports]
EXPOSE	20 21 30020 30021


# [Download packages]
RUN apk update && apk add --no-cache vsftpd openrc openssl \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& rm -rf /var/cache/apk/*


# [Configuration SSL certificate]
RUN mkdir ./ssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/O=42/CN=dchampda" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /ssl/nginx-selfsigned.key -out /ssl/nginx-selfsigned.crt


# [Configuration au lancement]
COPY vsftpd.conf /etc/vsftpd/
COPY telegraf.conf /etc/
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh


# [Config]
CMD sh /tmp/setup.sh