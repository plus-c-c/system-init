yay -S --noconfirm --needed katex
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/all-the-icons.ttf -o fonts/all-the-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/file-icons.ttf -o fonts/file-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/fontawesome.ttf -o fonts/fontawesome.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/material-design-icons.ttf -o fonts/material-design-icons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/octicons.ttf -o fonts/octicons.ttf
curl https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/weathericons.ttf -o fonts/weathericons.ttf
cp -r ./fonts ~/.local/share/fonts
mkdir ~/.local/share/fonts/KaTeX/
cp -r ./katex/fonts/* ~/.local/share/fonts/KaTeX/
fc-cache -fv
