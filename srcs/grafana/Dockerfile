# [Download image]
FROM alpine:3.12


# [Expose ports]
EXPOSE	3000

# [Download packages]
RUN apk update && apk add --no-cache openrc openssl \
	&& apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& apk add rsyslog \
	&& rm -rf /var/cache/apk/*

# [Configuration SSL certificate]
RUN mkdir ./ssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/O=42/CN=dchampda" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /ssl/nginx-selfsigned.key -out /ssl/nginx-selfsigned.crt

# [Configuration]
RUN mkdir /var/lib/grafana \
	&& mkdir /var/log/grafana
COPY telegraf.conf /etc/
COPY grafana.ini etc/
COPY grafana.db /var/lib/grafana/
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh




# [Config]
CMD sh /tmp/setup.sh