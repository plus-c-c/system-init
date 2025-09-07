yay -S --noconfirm --needed uwsm hyprland kitty
yay -S --noconfirm --needed xorg-xwayland lightdm web-greeter
sudo cp -f ./lightdm/lightdm.conf /etc/lightdm/
sudo systemctl enable lightdm
sudo systemctl start lightdm
