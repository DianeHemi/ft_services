# [Download image]
FROM alpine:3.12


# [Expose ports]
EXPOSE	8086


# [Download packages]
RUN apk update && apk add --no-cache influxdb openrc \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& rm -rf /var/cache/apk/*


# [Configuration]
RUN mkdir /var/lib/influxdb \
	&& chown influxdb:influxdb /var/lib/influxdb


# [Configuration au lancement]
COPY telegraf.conf /etc/
COPY influxdb.conf /etc/
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh


# [Config]
CMD sh /tmp/setup.sh