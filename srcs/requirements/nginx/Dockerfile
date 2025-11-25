FROM alpine:3.21

RUN apk update && apk add nginx && apk upgrade

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 644 /etc/nginx/nginx.conf

CMD ["custom-nginx", "-g", "daemon off;"]

