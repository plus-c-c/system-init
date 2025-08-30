sudo pacman -S --noconfirm --needed base-devel yay
yay -S --noconfirm --needed npm python-epc python-pyte python-pip python-watchdog
yay -S --noconfirm --needed ttf-cascadia-code-nerd wqy-microhei

git clone https://github.com/emacs-eaf/emacs-application-framework.git ~/.emacs.d/site-lisp/emacs-application-framework/
git clone https://github.com/manateelazycat/lsp-bridge.git  ~/.emacs.d/site-lisp/lsp-bridge/
git clone https://github.com/manateelazycat/fingertip.git  ~/.emacs.d/site-lisp/fingertip/
git clone https://github.com/manateelazycat/auto-save.git ~/.emacs.d/site-lisp/auto-save/

cd ~/.emacs.d/site-lisp/emacs-application-framework/
chmod +x ./install-eaf.py
./install-eaf.py --force -i emacs-application-framework browser pdf-viewer file-manager git pyqterminal file-sender image-viewer js-video-player

raco pkg install --auto racket-langserver
