FROM nginx:1.21.5-alpine

# Installing bash
RUN apk add --no-cache bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing other CLI tools
RUN apk add --no-cache \
    bind-tools \
    curl \
    git \
    vim \
    zip \
    unzip

# remove default NGINX confg
RUN rm -Rf /etc/nginx/conf.d/*.conf /usr/share/nginx/html

# copy custom NGINX configuration files
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# copy NGINX commands to run
COPY run.sh /etc/nginx/run.sh
RUN chmod +x /etc/nginx/run.sh

EXPOSE 80

CMD ["sh", "-c", "/etc/nginx/run.sh"]
