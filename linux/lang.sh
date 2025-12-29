# programming environment
yay -S --needed --noconfirm github-cli emacs


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
yay -S --noconfirm --needed wqy-microhei ttf-sourcecodepro-nerd ttf-cascadia-code-nerd otf-font-awesome otf-fira-mono xorg-fonts-misc ttf-ms-fonts

#mkdir ~/.local/share/fonts
#mkdir ~/.local/share/fonts/WindowsFonts
#cp /mnt/win/Windows/Fonts/* ~/.local/share/fonts/WindowsFonts/
#chmod 644 ~/.local/share/fonts/WindowsFonts/*
fc-cache -fv

### language IDE and LSP server
# markdown
yay -S --noconfirm --needed tree-sitter-markdown

# json
yay -S --noconfirm --needed vscode-json-languageserver

# js/ts
sudo npm install -g tsx typescript typescript-language-server @prisma/language-server

# racket
yay -S --noconfirm --needed racket
sudo raco pkg install --auto racket-langserver

# bash
yay -S --noconfirm --needed bash-language-server

# python
yay -S --noconfirm --needed python uv dasel python-debugpy pyright ruff ruff-lsp

# r
yay -S --noconfirm --needed r
sudo cp -f ./lang-conf/Renviron /etc/R/
sudo R -f "./lang-conf/install.R"

yay -S --noconfirm --needed r-vegan
# mindmap
yay -S --noconfirm --needed plantuml mermaid-cli
