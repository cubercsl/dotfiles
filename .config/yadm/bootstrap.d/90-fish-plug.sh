#!/bin/sh

FISH_CONFIG_PATH=${FISH_CONFIG_PATH:-$HOME/.config/fish}

if [ -d "$FISH_CONFIG_PATH/custom/scripts" ]; then
  echo "Bootstraping Fish"
  find "$FISH_CONFIG_PATH/custom/scripts" -type f | sort | while IFS= read -r script; do
    if [[ -x "$script" && ! "$script" =~ "##" && ! "$script" =~ "~$" ]]; then
      if ! "$script"; then
        echo "Warning: $script didn't return 0" >&2
      fi
    fi
  done
fi
