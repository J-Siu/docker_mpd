#!/bin/ash

PROG=/usr/bin/mpd
PUSR=mpd
PHOME=/${PUSR}

echo PGID:${PGID}
echo PUID:${PUID}

if [ "${PUID}" -lt "1000" ]
then
	echo PUID cannot be \< 1000
	exit 1
fi

if [ "${PGID}" -lt "1000" ]
then
	echo PGID cannot be \< 1000
	exit 1
fi


# detect and use host audio GID from /dev/snd/timer
AGID=$(stat -c %g /dev/snd/timer)
delgroup audio
addgroup -g ${AGID} audio

addgroup -g ${PGID} ${PUSR}
adduser -D -h ${PHOME} -G ${PUSR} -u ${PUID} ${PUSR}
adduser ${PUSR} audio
chown ${PUSR}:${PUSR} ${PHOME}

exec su - mpd -c "${PROG} \"--no-daemon\" \"/mpd.conf\""
# Debug
#exec su - mpd -c "${PROG} \"--stdout\" \"--no-daemon\" \"/mpd.conf\""