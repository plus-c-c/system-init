yay -S google-chrome android-studio flutter --noconfirm --needed
sudo pacman -S android-tools android-udev --noconfirm --needed
yay -S qemu-full libvirt --noconfirm --needed
sudo systemctl enable --now libvirtd
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
sudo pacman -S vulkan-radeon lib32-vulkan-radeon mesa mesa-utils --noconfirm --needed
yay -S dnsmasq dmidecode --noconfirm --needed
