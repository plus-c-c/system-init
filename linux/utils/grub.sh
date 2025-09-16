yay -S --noconfirm --needed grub os-prober
cd grub

sudo cp -f ./grub /etc/default

cp -f ../var.sh ./vimix/
cd ./vimix
chmod +x ./theme.sh
./theme.sh

sudo cp -rf ./Vimix/ /usr/share/grub/themes/

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
