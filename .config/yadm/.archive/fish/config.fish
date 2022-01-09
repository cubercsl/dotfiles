if status is-interactive && command -sq starship
    starship init fish | source
end

if status is-interactive && functions -q set_proxy
    set_proxy > /dev/null
end
