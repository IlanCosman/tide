function fish_prompt
end # In case this file gets loaded non-interactively, e.g by conda
status is-interactive || exit

_tide_remove_unusable_items

# When first installing, some variables just don't exist for some reason
test -n "$_tide_left_items$_tide_right_items" || exit

_tide_cache_variables

set -l prompt_var _tide_prompt_$fish_pid
set -U $prompt_var # Set var here so if we erase $prompt_var, bg job won't set a uvar

# _tide_repaint prevents us from creating a second background job
function _tide_refresh_prompt --on-variable $prompt_var --on-variable COLUMNS
    set -g _tide_repaint
    commandline -f repaint
end

set -l color_normal (set_color normal)
set -l fish_path (status fish-path)

set -l dirname (status dirname)
set -l leftPromptItemCode "$(cat $dirname/tide/items/_tide_item_{$_tide_left_items}.fish)"
set -l rightPromptItemCode "$(cat $dirname/tide/items/_tide_item_{$_tide_right_items}.fish)"
source $dirname/tide/functions/_tide_pwd.fish

# contains newline $_tide_left_items
if contains newline $_tide_left_items
    source $dirname/tide/functions/2_line_prompt_init.fish
else
    source $dirname/tide/functions/2_line_prompt_init.fish
end

eval "function _tide_on_fish_exit --on-event fish_exit
    set -e $prompt_var
end"
