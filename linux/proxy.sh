sudo npm -g config set proxy http://127.0.0.1:7890
sudo npm -g config set https-proxy http://127.0.0.1:7890

git config --global http.proxy "http://127.0.0.1:7890"
git config --global https.proxy "http://127.0.0.1:7890"
