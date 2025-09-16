###dpi
yay -S --noconfirm --needed xorg-xrandr

###window manager
yay -S --noconfirm --needed hyprland hyprpaper
cp -r ./UI/hypr/ ~/.config/

###basic software
yay -S --noconfirm --needed kitty thunar tofi

mkdir ~/.config/tofi
cp ./UI/tofi/config ~/.config/tofi
cp -r ./UI/waybar/ ~/.config/
cp ./UI/.Xresources ~/.Xresources
chmod +x ~/.config/hypr/tofi-args.sh
