apt install -y \
    syncthing \
    syncthing-relaysrv

useradd syncthing -m --home /srv/syncthing --shell /bin/nologin syncthing
# useradd syncthing -m --home /etc/strelaysrv --shell /bin/nologin strelaysrv

systemctl enable --now syncthing@syncthing.service

