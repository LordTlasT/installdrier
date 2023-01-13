url="$(curl 'https://github.com/aristocratos/btop/releases/latest' -i --silent | grep "^location" | awk '{print $2}' | sed 's;/tag;/download;g'| tr -d '\r')"
file="btop-x86_64-linux-musl.tbz"
url="${url}/${file}"
wget "${url}"
tar xf ${file}
rm ${file}
cd btop
make install
cd ..
rm -r btop
