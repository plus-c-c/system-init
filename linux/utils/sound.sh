sudo pacman --noconfirm --needed -S alsa-utils pulseaudio
sudo chmod 666 /etc/asound.conf
sudo echo "defaults.pcm.card 1
defaults.ctl.card 1
" > /etc/asound.conf
sudo chmod 644 /etc/asound.conf
