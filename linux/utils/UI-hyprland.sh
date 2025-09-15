###dpi
yay -S --noconfirm --needed xorg-xrandr

###window manager
yay -S --noconfirm --needed hyprland hyprpaper
cp -r ./UI/hypr/ ~/.config/

###basic software
yay -S --noconfirm --needed kitty dolphin tofi

mkdir ~/.config/tofi
mkdir ~/.config/waybar
cp ./UI/tofi/config ~/.config/tofi
cp -r ./UI/waybar/ ~/.config/
cp ./UI/.Xresources ~/.Xresources
