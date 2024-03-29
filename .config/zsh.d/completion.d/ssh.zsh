zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
    ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config.d/* 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config.d/**/* 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
zstyle ':completion:*:(ssh|scp|rsync|mosh|copy-gpg-db):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-host hosts-domain hosts-ipaddr
zstyle ':completion:*:(ssh|mosh|copy-gpg-db):*' group-order users hosts-host hosts-domain users hosts-ipaddr
# remove IP address, loopback, localhost and hostname from hosts list
zstyle ':completion:*:(ssh|scp|rsync|sshfs|mosh|copy-gpg-db):*:hosts-host' ignored-patterns \
    '*(.|:)*' \
    loopback ip6-loopback localhost ip6-localhost broadcasthost \
    $HOST \
    aur
# remove IP address, localdomain and useless doamin from domain list
zstyle ':completion:*:(ssh|scp|rsync|sshfs|mosh|copy-gpg-db):*:hosts-domain' ignored-patterns \
    '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*' \
    '*.localdomain' \
    '*.github*' 'github.com' 'aur.archlinux.org'
zstyle ':completion:*:(ssh|scp|rsync|sshfs|mosh|copy-gpg-db):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.<->.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*:(ssh|scp|rsync|sshfs|mosh|copy-gpg-db):*' users root git $USER

# vim: ft=zsh sw=4 ts=8 sts=4 et:
