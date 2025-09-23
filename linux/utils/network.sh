sudo npm -g config set proxy http://127.0.0.1:7890
sudo npm -g config set https-proxy http://127.0.0.1:7890

git config --global http.proxy "http://127.0.0.1:7890"
git config --global https.proxy "http://127.0.0.1:7890"

yay --noconfirm --needed -S clash-verge-rev-autobuild-bin
yay --noconfirm --needed -S chromium
pip install pycookiecheat --break-system-packages

sudo touch /etc/systemd/system/clash-verge-service.service
sudo chmod 666 /etc/systemd/system/clash-verge-service.service
sudo echo "
[Unit]
Description=Clash Verge Service helps to launch Clash Core.
After=network-online.target nftables.service iptables.service

[Service]
Type=simple
ExecStart=/usr/bin/sh -c /usr/bin/uninstall-service & /usr/bin/sh -c /usr/bin/install-service & /usr/bin/clash-verge-service
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/clash-verge-service.service
sudo chmod 644 /etc/systemd/system/clash-verge-service.service

sudo systemctl enable clash-verge-service
sudo systemctl start clash-verge-service
# Webdav
sudo mkdir /cloud
mkdir /cloud/webdav

yay --noconfirm --needed -S rclone

sudo rclone config create nutstore webdav url="https://dav.jianguoyun.com/dav" user=3559084904@qq.com pass=aifk3cfhse28ah9t --non-interactive

sudo chmod 666 /etc/fuse.conf
sudo echo "user_allow_other" > /etc/fuse.conf

sudo touch /etc/systemd/system/rclone-webdav.service
sudo chmod 666 /etc/systemd/system/rclone-webdav.service
sudo echo "[Unit]
Description=Mount Webdav using rclone
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount nutstore: /cloud/webdav --allow-other --allow-non-empty --vfs-cache-mode writes
ExecStop=/bin/fusermount3 -u /cloud/webdav
Restart=always
User=root

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/rclone-webdav.service

sudo systemctl enable rclone-webdav.service
sudo systemctl start rclone-webdav.service
sudo chmod 644 /etc/systemd/system/rclone-webdav.service

sudo touch /etc/systemd/system/rclone-webdav-sync.timer
sudo chmod 666 /etc/systemd/system/rclone-webdav-sync.timer

sudo echo "[Unit]
Description=Synchronize webdav path timer
After=network-online.target

[Timer]
OnUnitActiveSec=1m
Unit=rclone-webdav-sync.service

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/rclone-webdav-sync.timer
sudo chmod 644 /etc/systemd/system/rclone-webdav-sync.timer

sudo touch /etc/systemd/system/rclone-webdav-sync.service
sudo chmod 666 /etc/systemd/system/rclone-webdav-sync.service

sudo echo "[Unit]
Description=Synchronize webdav path
After=network-online.target

[Service]
ExecStart=/usr/bin/rclone sync nutstore: /cloud/webdav
User=root

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/rclone-webdav-sync.service

sudo chmod 644 /etc/systemd/system/rclone-webdav-sync.service
sudo systemctl enable rclone-webdav-sync.timer
sudo systemctl enable rclone-webdav-sync.service
