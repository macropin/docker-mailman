FROM debian:jessie

# run
# docker run -d -p 8080:80 -p 25:25 mailman
#
# http://localhost:8080/cgi-bin/mailman/admin

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nginx mailman postfix supervisor && \
    apt-get -y install vim
#    rm -rf /var/lib/apt/lists/*

# Cache spool dir as template
RUN cp -a /var/spool/postfix /var/spool/postfix.cache

ADD nginx.conf /etc/nginx/conf.d/
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD *.sh /

EXPOSE 25 80

VOLUME ["/etc/mailman/", "/var/lib/mailman", "/var/log/mailman", "/var/spool/postfix"]

ENTRYPOINT ["/entry.sh"]

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
