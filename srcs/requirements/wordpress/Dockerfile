FROM alpine:3.21.5

RUN apk upgrade && \
	apk update && \
	apk add --no-cache \ 
		bash \
		wget \
		tar \
		php84-fpm

RUN wget https://wordpress.org/latest.tar.gz;\
	tar -xzvf latest.tar.gz -C /usr/src/;\
	rm latest.tar.gz;\
	chown -R www-data:www-data /usr/src/wordpress /var/www/html

COPY tools/docker_entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm", "--nodaemonize"]
