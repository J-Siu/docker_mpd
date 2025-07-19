# docker_mpd
FROM alpine:edge

LABEL version="0.24.4-r1"
LABEL maintainers="[John Sing Dao Siu](https://github.com/J-Siu)"
LABEL name="mpd"
LABEL usage="https://github.com/J-Siu/docker_mpd/blob/master/README.md"
LABEL description="Docker - MPD with UID/GID + audio GID handling."

RUN apk --no-cache add mpd=0.24.4-r1 sqlite-libs

COPY docker-compose.yml env start.sh mpd.conf /
RUN chmod u+x /start.sh \
	&& mkdir /mpd

CMD ["/start.sh"]