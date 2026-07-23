git clone https://github.com/emacs-eaf/emacs-application-framework.git ~/.emacs.d/site-lisp/emacs-application-framework/
git clone https://github.com/manateelazycat/lsp-bridge.git  ~/.emacs.d/site-lisp/lsp-bridge/
git clone https://github.com/manateelazycat/fingertip.git  ~/.emacs.d/site-lisp/fingertip/
git clone https://github.com/manateelazycat/auto-save.git ~/.emacs.d/site-lisp/auto-save/

cd ~/AppData/Roaming/.emacs.d/site-lisp/emacs-application-framework/
./install-eaf.py --force -i emacs-application-framework browser pdf-viewer file-sender image-viewer video-player
pip install PyQt6-WebEngine sexpdata epc tld lxml pygetwindow
pip3 install epc orjson sexpdata six setuptools paramiko rapidfuzz watchdog packaging
cd ./app/file-manager
npm install --force
npm audit --force
