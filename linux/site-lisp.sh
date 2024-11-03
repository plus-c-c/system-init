git clone --depth=1 -b master https://github.com/radian-software/straight.el.git ~/.emacs.d/site-lisp/straight

sudo pacman -S --noconfirm --needed base-devel yay
yay -S --noconfirm -needed npm python-epc python-pyte python-pip
yay -S --noconfirm --needed ttf-cascadia-code-nerd oh-my-posh posh-git-sh wqy-microhei
sudo npm -g config set registry https://registry.npmmirror.com

git clone --depth=1 -b master https://github.com/emacs-eaf/emacs-application-framework.git ~/.emacs.d/site-lisp/emacs-application-framework/
cd ~/.emacs.d/site-lisp/emacs-application-framework/
chmod +x ./install-eaf.py
./install-eaf.py --force -i emacs-application-framework browser pdf-viewer file-manager git pyqterminal file-sender

git clone --depth=1 -b master https://github.com/manateelazycat/blink-search.git ~/.emacs.d/site-lisp/blink-search

git clone --depth=1 -b master https://github.com/manateelazycat/fingertip.git ~/.emacs.d/site-lisp/fingertip

git clone --depth=1 -b master https://github.com/manateelazycat/lsp-bridge.git ~/.emacs.d/site-lisp/lsp-bridge

git clone --depth=1 -b master https://github.com/manateelazycat/auto-save.git ~/.emacs.d/site-lisp/auto-save

pip install pymupdf frontend pynput inflect --break-system-packages
git clone --depth=1 -b master https://github.com/manateelazycat/holo-layer.git ~/.emacs.d/site-lisp/holo-layer
