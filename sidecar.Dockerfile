ARG ALPINE_TAG=latest

FROM alpine:$ALPINE_TAG

RUN apk add --no-cache \
        postgresql17-client \
        curl \
        jq

COPY restore_and_query.sh /usr/local/bin/restore_and_query.sh
RUN chmod +x /usr/local/bin/restore_and_query.sh

ENTRYPOINT ["/usr/local/bin/restore_and_query.sh"]