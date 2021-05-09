#!/bin/bash
system_type=$(uname -s)
[ $system_type != "Linux" ] && exit
[ ! -d ~/.config/tmux/plugins ] && git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
