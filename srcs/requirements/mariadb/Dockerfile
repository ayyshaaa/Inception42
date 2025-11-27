FROM alpine:3.21.5

COPY ["./tools/startNStop.sh", "/usr/local/bin"]

RUN apk add --no-cache \
	mariadb \
	mariadb-client && \
	chmod +x /usr/bin/local/startNStop.sh

ENTRYPOINT [ "startNStop.sh" ]