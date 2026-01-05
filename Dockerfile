FROM docker.io/library/httpd:2-alpine

# Redirect root directory to the /build/; also run on high port
RUN echo "RedirectMatch ^/$ /build/" | tee -a /usr/local/apache2/conf/httpd.conf && \
    sed -i -e 's/^Listen 80/Listen 8000/' /usr/local/apache2/conf/httpd.conf

COPY . /usr/local/apache2/htdocs

RUN adduser -u 1000 -D nonroot && \
    chown -R 1000:1000 /usr/local/apache2

# Indicate what port we will listen on
EXPOSE 8000

# Run as non-root
USER 1000

