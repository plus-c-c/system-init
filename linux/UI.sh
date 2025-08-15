yay -S --noconfirm --needed gnome
dbus-send --session --dest=org.freedesktop.secrets \
   --type=method_call  \
   /org/freedesktop/secrets \
   org.freedesktop.Secret.Service.Lock \
   array:objpath:/org/freedesktop/secrets/collection/login
sudo chmod +6 /etc/pam.d/login
sudo echo "auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
" >> /etc/pam.d/login
systemctl enable --user gcr-ssh-agent.socket
ssh-add -L
sudo chmod +666 "/run/user/$(id -u $USER)/keyring/control"
sudo chmod +666 "/run/user/$(id -u $USER)/keyring/pkcs11"
