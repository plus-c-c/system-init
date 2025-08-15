sudo npm -g config set proxy http://127.0.0.1:7890
sudo npm -g config set https-proxy http://127.0.0.1:7890

git config --global http.proxy "http://127.0.0.1:7890"
git config --global https.proxy "http://127.0.0.1:7890"

yay --noconfirm --needed -S clash-verge-rev
yay --noconfirm --needed -S google-chrome
pip install pycookiecheat --break-system-packages
