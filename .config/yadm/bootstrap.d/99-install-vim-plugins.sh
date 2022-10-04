#!/bin/bash -e

assets="$(cd "$(dirname ${BASH_SOURCE[0]})"; pwd)/assets"
if command -v vim >/dev/null 2>&1; then
  echo "Bootstraping Vim"
  # curl -fLo ~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
  vim '+JetpackSync' '+qall'
fi
