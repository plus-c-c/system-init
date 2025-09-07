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

sudo chmod 666 /etc/R/Renviron
yay -S --noconfirm --needed r
sudo echo "http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
" >> /etc/R/Renviron
sudo chmod 644 /etc/R/Renviron
sudo R -e 'install.packages("languageserver",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN")'
# texlive
yay --noconfirm --needed -S texlive texlive-lang texlab

# database
yay --noconfirm --needed -S postgresql
