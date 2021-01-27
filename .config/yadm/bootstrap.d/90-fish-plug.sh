#!/bin/sh

FISH_CONFIG_PATH=${FISH_CONFIG_PATH:-$HOME/.config/fish}

if [ -d "$FISH_CONFIG_PATH/custom/scripts" ]; then
  echo "Bootstraping Fish"
  for i in $FISH_CONFIG_PATH/custom/scripts/*.fish; do
    if [ -r $i ]; then
      fish $i
    fi
  done
  unset i
fi

