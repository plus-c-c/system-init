yay -S --noconfirm --needed sddm sddm-sugar-dark
sudo cp ./UI/sddm.conf /etc/
sudo systemctl enable sddm
sudo systemctl start sddm
