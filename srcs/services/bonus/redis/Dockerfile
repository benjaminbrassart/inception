FROM alpine:3.15.2

LABEL maintainer="bbrassar@student.42.fr"

RUN apk -U upgrade && apk add --no-cache redis

COPY script/run.sh /tmp/run.sh

# https://redis.io/docs/manual/admin/

ENTRYPOINT ["sh", "/tmp/run.sh"]
