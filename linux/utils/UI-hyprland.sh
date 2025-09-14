###dpi
yay -S --noconfirm --needed xorg-xrandr

###window manager
yay -S --noconfirm --needed hyprland
cp ./UI/hyprland.conf ~/.config/hypr

###basic software
yay -S --noconfirm --needed kitty dolphin tofi

mkdir ~/.config/tofi
mkdir ~/.config/waybar
cp ./UI/tofi/config ~/.config/tofi
cp ./UI/waybar/* ~/.config/waybar
