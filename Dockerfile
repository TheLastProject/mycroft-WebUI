FROM python:3-alpine

RUN apk --no-cache add git nginx

COPY root /

WORKDIR /app

RUN pip install -r requirements.txt

RUN chmod +x startup.sh \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 8080
EXPOSE 8443

VOLUME /config

ENTRYPOINT ["/app/startup.sh"]
