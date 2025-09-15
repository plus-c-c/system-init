#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(oh-my-posh init bash --config "~/.config/terminal/atomicBit.omp.json")"
export http_proxy=http://localhost:7890
export https_proxy=http://localhost:7890
export GLFW_IM_MODULE=fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export LC_CTYPE=zh_CN.UTF-8
export XMODIFIERS="@im=fcitx"
