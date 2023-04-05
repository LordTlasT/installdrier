#!/bin/sh

# quick install (and run) script for yt-local using systemd
if [ "$(id -u)" -ne 0 ]
then
	echo "Please run as root"
	exit 1
fi

useradd -s /bin/sh -r -d "${YTDIR:=/srv/yt-local}" "${YTUSER:=yt-local}" ||
	exit 1
mkdir -p "$YTDIR" # dodge copying of skeletons ||
	exit 1

chown "$YTUSER:$YTUSER" "$YTDIR"
chmod 700 "$YTDIR"

su "$YTUSER" -c'
cd
git clone https://git.sr.ht/~heckyel/yt-local . ||
	exit 1

python3 -m venv env
. ./env/bin/activate
pip install -r requirements.txt ||
	exit 1'
