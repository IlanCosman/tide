for var in $fake_tide_var_list
    set -e $var
end

set -g fake_tide_var_list

function _set -a var_name
    set -g $var_name $argv[2..-1]
    set -a fake_tide_var_list $var_name
end

# -------------------Local Variables-------------------
set -l tideColorGold D7AF00
set -l tideColorDarkerGreen 5FAF00

# ---------------General Theme Variables---------------
_set fake_tide_newline 'true'
# ---------Prompt Connection---------
_set fake_tide_prompt_connection_color 6C6C6C
_set fake_tide_prompt_connection_icon ' '

# --------------------Prompt Items--------------------
_set fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
_set fake_tide_right_prompt_items
# ------------Prompt Char------------
_set fake_tide_prompt_char_success_color magenta
_set fake_tide_prompt_char_failure_color red
_set fake_tide_prompt_char_icon '❯'
# ----------------Pwd----------------
_set fake_tide_pwd_truncate_margin 10
_set fake_tide_pwd_unwritable_icon
_set fake_tide_pwd_max_dirs 0
_set fake_tide_pwd_anchors
_set fake_tide_pwd_color_anchors $_tide_color_light_blue
_set fake_tide_pwd_color_dirs blue
_set fake_tide_pwd_color_truncated_dirs 8787AF
# ------------Git prompt------------
_set fake___fish_git_prompt_showupstream true
_set fake___fish_git_prompt_showdirtystate true
# -------Symbols-------
_set fake___fish_git_prompt_char_stateseparator ''
_set fake___fish_git_prompt_char_upstream_equal ''
_set fake___fish_git_prompt_char_upstream_ahead ' ⇡'
_set fake___fish_git_prompt_char_upstream_behind ' ⇣'
_set fake___fish_git_prompt_char_upstream_diverged ' ⇡⇣'
_set fake___fish_git_prompt_char_dirtystate ''
_set fake___fish_git_prompt_char_stagedstate '*'
# --------Colors--------
_set fake___fish_git_prompt_color_branch brblack
_set fake___fish_git_prompt_color_upstream cyan
_set fake___fish_git_prompt_color_stagedstate brblack
# --------------Status--------------
_set fake_tide_status_success_icon '✔'
_set fake_tide_status_success_color $tideColorDarkerGreen
_set fake_tide_status_failure_icon '✘'
_set fake_tide_status_failure_color D70000
# -----------Cmd_Duration-----------
_set fake_tide_cmd_duration_color yellow
_set fake_tide_cmd_duration_decimals 0
_set fake_tide_cmd_duration_threshold 3000
# --------------Context--------------
_set fake_tide_context_ssh_color D7AF87
_set fake_tide_context_root_color $tideColorGold
# ---------------Jobs---------------
_set fake_tide_jobs_icon '' # Gear
_set fake_tide_jobs_color $tideColorDarkerGreen
# ---------------Time---------------
_set fake_tide_time_color 6C6C6C
_set fake_tide_time_format '%T'

cat "$_tide_dir/configure/fish_prompt.fish" >"$__fish_config_dir/functions/fish_prompt.fish"