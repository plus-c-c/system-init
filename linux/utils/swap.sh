sudo mkswap -U clear --size 16G --file /home/swapfile
sudo swapon /home/swapfile
sudo chmod 666 /etc/fstab
sudo echo "/home/swapfile none swap defaults 0 0

" >> /etc/fstab
sudo chmod 644 /etc/fstab
