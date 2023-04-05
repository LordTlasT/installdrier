apt install -y syncthing

useradd -d /srv/syncthing -s /usr/sbin/nologin -r syncthing
mkdir /srv/syncthing
chown syncthing:syncthing /srv/syncthing
chmod 700 /srv/syncthing

systemctl enable --now syncthing@syncthing.service
