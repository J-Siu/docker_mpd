Docker MPD Lite with UID/GID + audio GID handling.

### Build

```sh
git clone https://github.com/J-Siu/docker_mpd.git
cd docker_mpd
docker build -t jsiu/mpd .
```

### Usage

#### Host Directories and Volume Mapping

Host|Inside Container|Mapping Required|Usage
---|---|---|---
${MPD_PATH_CONF}|/mpd.conf|Optional|MPD configuration file
${MPD_PATH_MPD}|/mpd/.mpd|Yes|Contain playlists folder, state file, database file
${MPD_PATH_MUSIC}|/mpd/music|Yes|MPD audio file folder
${MPD_PORT}|6000/tcp|Yes|MPD listening port
${MPD_SND}||Yes|MPD output device

Create playlists director inside ${MPD_PATH_MPD} if not exist yet.

```sh
mkdir -p ${MPD_PATH_MPD}/playlists
```

#### MPD_UID / MPD_GID

ENV VAR|Usage
---|---
MPD_UID|UID of ${MPD_PATH_MPD},${MPD_PATH_MUSIC} owner
MPD_GID|GID of ${MPD_PATH_MPD},${MPD_PATH_MUSIC} owner

#### Run

```docker
docker run \
-d \
-e PUID=${MPD_UID} \
-e PGID=${MPD_GID} \
-p ${MPD_PORT}:6600/tcp \
-v ${MPD_PATH_MPD}:/mpd/.mpd \
-v ${MPD_PATH_MUSIC}:/mpd/music \
--device ${MPD_SND} \
--cap-add sys_nice \
jsiu/docker_mpd
```

Example:

If ${MPD_PATH_MPD} and ${MPD_PATH_MUSIC} owner's UID=1001 and GID=1002:

```docker
docker run \
-d \
-e PUID=1001 \
-e PGID=1002 \
-p 6600:6600/tcp \
-v /home/jsiu/MPD:/mpd/.mpd \
-v /home/jsiu/Music:/mpd/music \
--device /dev/snd \
--cap-add sys_nice \
jsiu/docker_mpd
```

#### Debug / Custom Config

Get config from image:

```docker
docker run --rm jsiu/docker_mpd cat /mpd.conf > mpd.conf
```

Change mpd.conf log_level to verbose:

```conf
log_level  "verbose"
```

Run with mpd.conf mapping:

```docker
docker run \
-e PUID=1001 \
-e PGID=1002 \
-p 6600:6600/tcp \
-v /home/jsiu/mpd.conf:/mpd.conf \ # Map mpd.conf into container
-v /home/jsiu/MPD:/mpd/.mpd \
-v /home/jsiu/Music:/mpd/music \
--device /dev/snd \
jsiu/docker_mpd
```

#### Compose

Get docker-compose template from image:

```docker
docker run --rm jsiu/mpd cat /docker-compose.yml > docker-compose.yml
docker run --rm jsiu/mpd cat /env > .env
```

Fill in `.env` according to your environment.

```sh
docker-compose up
```

### Repository

- [docker_compose](https://github.com/J-Siu/docker_mpd)

### Contributors

- [John Sing Dao Siu](https://github.com/J-Siu)

### Change Log

- 0.21.14
  - Matching mpd version number
  - Base image: alpine:edge
  - mpd version: 0.21.14
- 0.21.19
  - mpd version: 0.21.19
- 0.21.22
  - mpd version: 0.21.22
- 0.21.23
  - mpd version: 0.21.23
- 0.21.24
  - mpd version: 0.21.24
  - start.sh
    - Use exec so start.sh can exit
    - Add exit code 1
    - Remove delgroup/deluser ${PUSR}
- 0.21.25-r0
  - Auto update to 0.21.25-r0
<!--CHANGE-LOG-END-->

### License

The MIT License

Copyright (c) 2020

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
