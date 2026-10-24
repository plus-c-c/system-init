### dpi
yay -S --noconfirm --needed xorg-xrandr

### window manager
yay -S --noconfirm --needed hyprland hyprpaper brightnessctl
cp -r ./UI/hypr/ ~/.config/

### basic software
yay -S --noconfirm --needed kitty thunar tofi totem fluidsynth soundfont-fluid xdg-utils desktop-file-utils

mkdir -p ~/.config/kitty
[ -f ~/.config/kitty/kitty.conf ] || cp ./UI/kitty.conf ~/.config/kitty/kitty.conf

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

### screen share
yay -S --noconfirm --needed xdg-desktop-portal-hyprland pipewire wireplumber
yay -S --noconfirm --needed luajit linux-headers v4l2loopback-dkms
yay -S --noconfirm --needed obs-studio

sudo usermod -aG video $USER
