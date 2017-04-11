FROM sgtsquiggs/alpine:3.4

MAINTAINER sgtsquiggs

# install packages
RUN \
    apk add --no-cache \
        git \
        logrotate \
        nginx \
        openssl &&\

# configure nginx
    echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
    /etc/nginx/fastcgi_params &&\
    rm -f /etc/nginx/conf.d/default.conf &&\

# fix logrotate
    sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
