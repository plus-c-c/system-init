
yay -S --noconfirm --needed gnome
yay -Rss --noconfirm epiphany gdm

# input method
yay --noconfirm --needed -S fcitx5-im fcitx5-chinese-addons gnome-shell-extension-kimpanel-git
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule':<'fcitx'>}"
