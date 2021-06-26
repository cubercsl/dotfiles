set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
switch (uname)
case Darwin
case Linux
    set -gx GPG_TTY (tty)
end
