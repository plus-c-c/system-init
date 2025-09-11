
yay -S --noconfirm --needed gnome
yay -Rss --noconfirm epiphany gdm



#yay -S --noconfirm --needed i3 xcompmgr xorg-xrandr mate-power-manager network-manager-applet thunar dmenu feh qterminal
yay -S --noconfirm --needed lightdm web-greeter
sudo cp -f ./UI/lightdm.conf /etc/lightdm/
cp -rf ./UI/i3 ~/.config/
cp -rf ./UI/Pictures ~/
chmod 777 ~/.config/i3/wallpaper.sh

sudo systemctl enable lightdm
sudo systemctl start lightdm

# input method
yay --noconfirm --needed -S fcitx5-im fcitx5-chinese-addons gnome-shell-extension-kimpanel-git
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule':<'fcitx'>}"
#echo "export GLFW_IM_MODULE=ibus" >> ~/.bashrc
#sudo cp -f ./UI/kitty.conf ~/.config/kitty/kitty.conf
#echo "Xft.dpi: 192" > ~/.Xresources
