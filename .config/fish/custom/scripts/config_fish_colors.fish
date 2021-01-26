# Theme-aware Fish shell color config
# Tested with iTerm2 Snazzy theme (https://github.com/sindresorhus/iterm2-snazzy)

# Test:
# echo "quote" > redirection;;; error param $operator \x42 # comment
set -U fish_color_command blue -o
set -U fish_color_quote green
set -U fish_color_redirection magenta
set -U fish_color_end cyan
set -U fish_color_error red
set -U fish_color_param yellow
set -U fish_color_comment brblack
set -U fish_color_operator magenta
set -U fish_color_escape cyan
set -U fish_color_autosuggestion brblack

# Test:
# commandline --insert 'set ' && commandline --function complete
set -U fish_pager_color_progress black --background=white
set -U fish_pager_color_prefix --bold
set -U fish_pager_color_description yellow

# Remove variables for default prompt
# fish_color_match is deprecated in Fish 3.2
for var in cwd cwd_root user host host_remote status match
    set -e fish_color_$var
end

