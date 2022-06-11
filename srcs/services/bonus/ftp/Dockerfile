FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache vsftpd

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]
