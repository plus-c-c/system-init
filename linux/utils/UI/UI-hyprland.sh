###dpi
yay -S --noconfirm --needed xorg-xrandr

###display manager

#yay -S --noconfirm --needed lightdm web-greeter
#sudo cp -f ./UI/lightdm.conf /etc/lightdm/

yay -S --noconfirm --needed sddm sddm-sugar-dark
sudo cp ./UI/sddm.conf /etc/
sudo systemctl enable sddm
sudo systemctl start sddm
###window manager
yay -S --noconfirm --needed hyprland
cp ./UI/hyprland.conf ~/.config/hypr

###basic software
yay -S --noconfirm --needed kitty dolphin wofi
