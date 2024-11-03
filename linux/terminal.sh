cp -rf ./terminal/ ~/Terminal
echo 'eval "$(oh-my-posh init bash --config "~/Terminal/atomicBit.omp.json")"' >> ~/.bashrc
echo 'export PATH=~/.local/bin/:$PATH' >> ~/.bash_profile
