# Fcitx
[[ $XDG_SESSION_TYPE != wayland ]] && export QT_IM_MODULE=fcitx
[[ $XDG_SESSION_TYPE != wayland ]] && export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# GPG Agent
export SSH_AGENT_PID=
export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh

# Theme
export GTK_USE_PORTAL=1

# TimeZone
export TZ=Asia/Shanghai

# VA-API
export LIBVA_DRI3_DISABLE=1

# Steam HIDPI
export STEAM_FORCE_DESKTOPUI_SCALING=1.5

# HiDPI
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export PLASMA_USE_QT_SCALING=1

