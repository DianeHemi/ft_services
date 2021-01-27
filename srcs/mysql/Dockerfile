# [Download image]
FROM alpine:3.12


# [Expose ports]
EXPOSE	3306


# [Download packages]
RUN apk add --no-cache mysql mysql-client openrc \
	&& apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	&& rm -rf /var/cache/apk/*

# [Files permissions]
RUN mkdir www/ \
	&& chown -R mysql:mysql /var/lib/mysql



# [Configuration BDD]
COPY mariadb_user_creation.sql /www/
COPY wordpress_db.sql /www/
COPY mariadb-server.cnf /etc/my.cnf.d/
COPY telegraf.conf /etc/



# [Configuration au lancement]
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh




# [Config]
CMD sh /tmp/setup.sh