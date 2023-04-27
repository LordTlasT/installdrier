#!/bin/sh
wget https://github.com/erebe/wstunnel/releases/download/v5.1/wstunnel-linux-x64
mv wstunnel-linux-x64 /usr/local/bin/wstunnel
chmod +x /usr/local/bin/wstunnel
wget https://github.com/jnsgruk/wireguard-over-wss/blob/master/wstunnel.sh
mv wstunnel.sh /etc/wireguard/wstunnel.sh
chmod +x /etc/wireguard/wstunnel.sh
