yay -S --noconfirm --needed sddm sddm-sugar-dark
sudo cp ./UI/sddm/sddm.conf /etc/
sudo cp -f ./UI/sddm/Background.jpg /usr/share/sddm/themes/sugar-dark/
sudo systemctl enable sddm
sudo systemctl start sddm
