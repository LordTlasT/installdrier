#!/bin/sh
apt-get update -y
apt-get install -y libzip-dev libssl-dev libcrypt-dev fcgiwrap
git clone --depth 1 https://git.zx2c4.com/cgit/ ||
	exit 1
cd cgit
git submodule init && git submodule update && make ||
	exit 1
make install

mkdir -p /srv/cgit/repos /srv/cgit/conf
cp -r /var/www/htdocs/cgit /srv/cgit/conf

chown -R www-data:www-data /srv/cgit
