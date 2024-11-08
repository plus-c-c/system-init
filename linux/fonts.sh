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
fc-cache -fv
