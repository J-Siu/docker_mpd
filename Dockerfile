# docker_mpd
FROM alpine:edge
ARG VERSION="0.24.12-r0"
LABEL version=${VERSION}
LABEL maintainers="[John Sing Dao Siu](https://github.com/J-Siu)"
LABEL name="mpd"
LABEL usage="https://github.com/J-Siu/docker_mpd/blob/master/README.md"
LABEL description="Docker - MPD with UID/GID + audio GID handling."

COPY docker-compose.yml env start.sh mpd.conf /
RUN apk --no-cache add mpd=${VERSION} sqlite-libs \
	&& chmod u+x /start.sh \
	&& mkdir /mpd

CMD ["/start.sh"]
