yay -S --noconfirm --needed  oh-my-posh posh-git-sh
cp -rf ./terminal/ ~/Terminal
echo 'eval "$(oh-my-posh init bash --config "~/Terminal/atomicBit.omp.json")"' >> ~/.bashrc
echo 'export PATH=~/.local/bin/:$PATH' >> ~/.bash_profile
