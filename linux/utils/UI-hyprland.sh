### dpi
yay -S --noconfirm --needed xorg-xrandr

### window manager
yay -S --noconfirm --needed hyprland hyprpaper brightnessctl
cp -r ./UI/hypr/ ~/.config/

### basic software
yay -S --noconfirm --needed kitty thunar tofi

mkdir ~/.config/tofi
cp ./UI/tofi/config ~/.config/tofi
cp -r ./UI/waybar/ ~/.config/

### hidpi
source ./var.sh
XDPI=$((96*GLOBAL_SCALE_FACTOR))
echo "Xft.dpi: $XDPI" > ~/.Xresources

### application args
chmod +x ~/.config/hypr/tofi-args.sh

### screen shot
yay -S --noconfirm --needed hyprshot-gui
### dark mode
yay -S --noconfirm --needed gnome-themes-extra adwaita-qt5-git adwaita-qt6-git
