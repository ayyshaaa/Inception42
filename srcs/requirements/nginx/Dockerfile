FROM alpine:3.21.5

RUN apk upgrade && \
	apk update && \
	apk add --no-cache \
		bash \
		openssl \
		ca-certificates \
		vim \
		iproute2 \
		curl \
		busybox-extras \
		nginx

RUN addgroup -g 82 -S www-data 2>/dev/null || true && \
	adduser -u 82 -D -S -G www-data www-data 2>/dev/null || true && \
	mkdir -p /var/www/html 2>/dev/null || true && \
	chown -R www-data:www-data /var/www/html 2>/dev/null || true && \
	mkdir -p /etc/nginx/ssl

COPY conf/custom-nginx.conf /etc/nginx/http.d/default.conf
COPY tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 555 /usr/local/bin/docker-entrypoint.sh && \
	chown -R www-data:www-data /etc/nginx/http.d/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

