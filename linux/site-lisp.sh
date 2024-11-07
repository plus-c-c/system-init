sudo pacman -S --noconfirm --needed base-devel yay
yay -S --noconfirm -needed npm python-epc python-pyte python-pip
yay -S --noconfirm --needed ttf-cascadia-code-nerd wqy-microhei

cd ~/.emacs.d/site-lisp/emacs-application-framework/
chmod +x ./install-eaf.py
./install-eaf.py --force -i emacs-application-framework browser pdf-viewer file-manager git pyqterminal file-sender
