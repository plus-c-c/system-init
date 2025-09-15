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

yay -S --noconfirm --needed r
sudo cp -f ./lang-conf/Renviron /etc/R/
sudo R -e 'install.packages("languageserver",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN")'

sudo raco pkg install --auto racket-langserver

# texlive
yay --noconfirm --needed -S texlive texlive-lang texlab

# database
yay --noconfirm --needed -S postgresql

# fonts
mkdir all-the-icons
mkdir ~/.local/share/fonts/all-the-icons/
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/all-the-icons.ttf -o all-the-icons/all-the-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/file-icons.ttf -o all-the-icons/file-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/fontawesome.ttf -o all-the-icons/fontawesome.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/material-design-icons.ttf -o all-the-icons/material-design-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/octicons.ttf -o all-the-icons/octicons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/weathericons.ttf -o all-the-icons/weathericons.ttf
cp -r ./all-the-icons/* ~/.local/share/all-the-icons/
mkdir ~/.local/share/fonts/KaTeX/
cp -r ./katex/fonts/* ~/.local/share/fonts/KaTeX/
yay -S --noconfirm --needed wqy-microhei ttf-sourcecodepro-nerd ttf-cascadia-code-nerd otf-font-awesome otf-fira-mono xorg-fonts-misc
fc-cache -fv
