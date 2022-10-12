FROM alpine:3.15.6

LABEL maintainer="bbrassar@student.42.fr"

ARG CADVISOR_VER=0.39.3
ARG CADVISOR_URI="https://github.com/google/cadvisor/releases/download/v0.39.3/cadvisor"

RUN apk -U upgrade && apk add --no-cache libc6-compat curl

RUN curl -L ${CADVISOR_URI} -o /usr/bin/cadvisor && chmod +x /usr/bin/cadvisor

ENTRYPOINT [ "cadvisor" ]
