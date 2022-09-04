#!/bin/bash
set -eu

echo "Install Packages"
packages_file="$(dirname ${BASH_SOURCE[0]})/packages.conf"

function check_linux() {

  if grep -q -E -i "debian|ubuntu" /etc/issue; then
    echo "debian"
  elif grep -q -E -i "Arch|Manjaro" /etc/issue; then
    echo "arch"
  else
    echo "unknown"
  fi
}

system_type=$(uname -s)

if [ "$system_type" = "Linux" ]; then
    release=$(check_linux)

    sudo -v

    declare -a packages

    if [[ -f "${packages_file}" ]]; then
        mapfile -t < "${packages_file}"
    fi

    for line in "${MAPFILE[@]}"; do
        if [[ ! "${line}" =~ ^[[:space:]]*#.* ]]; then
            packages+=("${line}")
        fi
    done

    case ${release} in
        debian)
            sudo apt-get update -y
            sudo apt-get install -y "${pakages[@]}"
            ;;
        arch)
            sudo pacman -Syu --noconfirm --needed "${packages[@]}"
            ;;
    esac
elif [ "$system_type" = "Darwin" ]; then
    ::
fi

