set -g add_prefix
set -g _tide_side left
# @ left side goes here @
set_color $prev_bg_color -b normal
echo $tide_left_prompt_suffix

set -g add_prefix
set -g _tide_side right
# @ right side goes here @
set_color $prev_bg_color -b normal
echo $tide_right_prompt_suffix
