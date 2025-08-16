# programming environment
yay -S --needed --noconfirm github-cli emacs

# lenguage IDE and LSP server
yay -S --noconfirm --needed tree-sitter-markdown

yay -S --noconfirm --needed vscode-json-languageserver

yay -S --noconfirm --needed racket
raco pkg install racket-langserver

yay -S --noconfirm --needed bash-language-server

pip install python-lsp-bridge --break-system-packages

sudo npm install -g tsx typescript typescript-language-server @prisma/language-server

yay --noconfirm --needed -S texlive texlive-lang texlab

# input method
yay --noconfirm --needed -S fcitx5-im fcitx5-chinese-addons gnome-shell-extension-kimpanel-git
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule':<'fcitx'>}"
# database
yay --noconfirm --needed -S postgresql
