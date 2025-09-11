#!/bin/bash
chmod +x ./var.sh
source ./var.sh
scaled_text_size=$((16*GLOBAL_SCALE_FACTOR))
echo "Current font spec:" $scaled_text_size
theme_conf='# GRUB2 gfxmenu Linux theme\n
# Designed for any resolution\n
\n
# Global Property\n
title-text: ""\n
desktop-image: "background.jpg"\n
desktop-color: "#000000"\n
terminal-font: "Terminus Regular 18"\n
terminal-box: "terminal_box_*.png"\n
terminal-left: "0"\n
terminal-top: "0"\n
terminal-width: "100%"\n
terminal-height: "100%"\n
terminal-border: "0"\n
\n
# Show the boot menu\n
+ boot_menu {\n
  left = 30%\n
  top = 30%\n
  width = 40%\n
  height = 40%\n
  item_font = "DejaVu Sans Regular '${scaled_text_size}'"\n
  item_color = "#cccccc"\n
  selected_item_color = "#ffffff"\n
  icon_width = 48\n
  icon_height = 48\n
  item_icon_space = 24\n
  item_height = 56\n
  item_padding = 8\n
  item_spacing = 16\n
  selected_item_pixmap_style = "select_*.png"\n
}\n
\n
+ image {\n
  top = 100%-76\n
  left = 50%-360\n
  width = 720\n
  height = 63\n
  file = "info.png"\n
}\n

# Show a countdown message using the label component\n
+ label {\n
  top = 82%\n
  left = 32%\n
  width = 36%\n
  align = "center"\n
  id = "__timeout__"\n
  text = "Booting in %d seconds"\n
  color = "#cccccc"\n
  font = "DejaVu Sans Regular '${scaled_text_size}'"\n
}'
touch ./Vimix/theme.txt
echo -e $theme_conf> ./Vimix/theme.txt
