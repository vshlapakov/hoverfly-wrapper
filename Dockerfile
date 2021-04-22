FROM spectolabs/hoverfly:v1.3.2

RUN apk add --no-cache supervisor nginx && \
    rm -rf /var/cache/apk/*
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data

ADD hoverfly-wrapper.sh /sbin/hoverfly-wrapper.sh
RUN chmod +x /sbin/hoverfly-wrapper.sh

ADD nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
