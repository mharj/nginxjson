FROM nginx:alpine
RUN apk update \
    && apk add --no-cache jq 
COPY 99-env-settings.sh /docker-entrypoint.d
RUN chmod 775 /docker-entrypoint.d/99-env-settings.sh