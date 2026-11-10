# docker_mpd
FROM alpine:edge
ARG APP="mpd"
ARG VER="0.24.18-r0"
ARG USR="https://github.com/J-Siu"
LABEL version=${VER}
LABEL maintainers="[John Sing Dao Siu](${USR})"
LABEL name=${APP}
LABEL usage="${USR}/docker_${APP}/blob/master/README.md"
LABEL description="Docker - MPD with UID/GID + audio GID handling."

COPY docker-compose.yml env start.sh mpd.conf /
RUN apk --no-cache add \
${APP}=${VER} \
ca-certificates \
ca-certificates-bundle \
tzdata \
&& chmod u+x /start.sh \
&& mkdir /mpd

CMD ["/start.sh"]
