FROM nginx:1.19-alpine

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache tini=0.19.0-r0 && tini --version && which tini && \
    chmod +x /sbin/tini

RUN getent group newnginx || addgroup -S -g 1003 newnginx; getent passwd newnginx || adduser -S -u 1003 -G newnginx newnginx

RUN apk add --no-cache libcap && setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

RUN mkdir -p  /var/log/nginx /var/cache/nginx/proxy_temp /var/cache/nginx/client_temp /usr/share/nginx/html && \
    chown -R newnginx:newnginx  /var/log/nginx /var/cache/nginx /usr/share/nginx

RUN sed -i -e '/^user /d' -e 's/^pid /# pid /g' /etc/nginx/nginx.conf

USER newnginx

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]
