#!/bin/bash

if command -v tmux >/dev/null 2>&1; then
  echo "Bootstraping Tmux"
  TMUX_PLUGIN_MANAGER_PATH=$(tmux start-server\; show-environment -g TMUX_PLUGIN_MANAGER_PATH | cut -f2 -d=)
  [ -x "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins" ] &&\
    "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins"
fi
