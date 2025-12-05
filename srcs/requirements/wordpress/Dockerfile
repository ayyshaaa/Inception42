FROM alpine:3.21.5

RUN apk upgrade && \
	apk update && \
	apk add --no-cache \ 
		bash \
		curl \
		php-curl \
		php-date \
		php-dom \
		php-filter \
		php-ftp \
		php-gd \
		php-hash \
		php-iconv \ 
		php-json \
		php-libxml \
		php-mbstring \
		php-mysqli \
		php-openssl \
		php-pcre \
		php-posix \
		php-sockets \
		php-tokenizer \
		php-xml \
		php-xmlreader \
		php-zlib \
		php-zip \
		php-phar \
		php-cli \
		php-fpm \

RUN addgroup -g 82 -S www-data 2>/dev/null || true && \
	adduser -u 82 -D -S -G www-data www-data 2>/dev/null || true && \
	mkdir -p /var/www/html 2>/dev/null || true && \
	chown -R www-data:www-data /var/www/html 2>/dev/null || true

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm", "-F"]
