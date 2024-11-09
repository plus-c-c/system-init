yay -S --noconfirm --needed tree-sitter-markdown
yay -S --noconfirm --needed vscode-json-languageserver
yay -S --noconfirm --needed racket
yay -S --noconfirm --needed bash-language-server
pip install python-lsp-bridge --break-system-packages

sudo npm install -g tsx typescript typescript-language-server @prisma/language-server

yay -S --noconfirm --needed mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
sudo chown -R mysql:mysql /var/lib/mysql
sudo chmod -R +777 /var/lib/mysql
