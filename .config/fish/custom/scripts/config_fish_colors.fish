#!/usr/bin/env fish
# Theme-aware Fish shell color config
# Tested with iTerm2 Snazzy theme (https://github.com/sindresorhus/iterm2-snazzy)

# Test:
# echo "quote" > redirection;;; error param $operator \x42 # comment
set -U fish_color_autosuggestion '555'  'brblack'
set -U fish_color_cancel -r
set -U fish_color_command --bold
set -U fish_color_comment red
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end brmagenta
set -U fish_color_error brred
set -U fish_color_escape 'bryellow'  '--bold'
set -U fish_color_history_current --bold
set -U fish_color_host normal
set -U fish_color_match --background=brblue
set -U fish_color_normal normal
set -U fish_color_operator bryellow
set -U fish_color_param cyan
set -U fish_color_quote yellow
set -U fish_color_redirection brblue
set -U fish_color_search_match 'bryellow'  '--background=brblack'
set -U fish_color_selection 'white'  '--bold'  '--background=brblack'
set -U fish_color_user brgreen
set -U fish_color_valid_path --underline


# Test:
# commandline --insert 'set ' && commandline --function complete
set -U fish_pager_color_progress black --background=white
set -U fish_pager_color_prefix --bold
set -U fish_pager_color_description yellow
