#!/bin/sh
apt install -y curl unzip nginx certbot php-fpm php-mysql php-cli php7.4-mbstring php7.4-curl php7.4-xml php7.4-sqlite3 php7.4-json

mkdir -p /var/www/rss-bridge
cd /var/www/rss-bridge

wget -q --show-progress "https://github.com/RSS-Bridge/rss-bridge/archive/refs/tags/2023-03-22.zip"
unzip 2023-03-22.zip

mv rss-bridge-2023-03-22/* .
rm -rf rss-bridge-2023-03-22 2023-03-22.zip
chown -R www-data:www-data .

# $ must be escaped
cat > /etc/nginx/sites-available/rss-bridge <<EOF
server {
    listen 80;
    server_name rss-bridge.craftmenners.men;
    root /var/www/rss-bridge;
    index index.php;

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_read_timeout 60s;
        fastcgi_pass unix:/run/php/php-fpm.sock;
    }
}
EOF

ln -s /etc/nginx/sites-available/rss-bridge /etc/nginx/sites-enabled/rss-bridge

systemctl reload nginx
