# docker_mpd
FROM alpine:edge

LABEL version="0.21.25-r0"
LABEL maintainers="[John Sing Dao Siu](https://github.com/J-Siu)"
LABEL name="mpd"
LABEL usage="https://github.com/J-Siu/docker_mpd/blob/master/README.md"

RUN apk --no-cache add mpd=0.21.25-r0 sqlite-libs

COPY docker-compose.yml env start.sh mpd.conf /
RUN chmod u+x /start.sh \
	&& mkdir /mpd

CMD ["/start.sh"]