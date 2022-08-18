FROM nginx:alpine
COPY 99-env-settings.sh /docker-entrypoint.d/99-env-settings.sh
RUN apk update \
    && apk add jq \
    && rm -rf /var/cache/apk/* \
    chmod 775 /docker-entrypoint.d/99-env-settings.sh