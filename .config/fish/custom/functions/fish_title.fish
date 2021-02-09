function fish_title
    # emacs is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS
        set realhome ~
        set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)
        echo (whoami)@(prompt_hostname): $tmp
    end
end
