# -------------------Local Variables-------------------
set -l tideColorGold D7AF00
set -l tideColorDarkerGreen 5FAF00

# ---------------General Theme Variables---------------
_set fake_tide_newline 'true'
# ------------Left Prompt------------
_set fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
_set fake_tide_left_prompt_item_separator_same_color ' '
_set fake_tide_left_prompt_item_separator_diff_color ' '
_set fake_tide_left_prompt_pad_separators false
_set fake_tide_left_prompt_prefix ''
# ------------Right Prompt------------
_set fake_tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs'
_set fake_tide_right_prompt_item_separator_same_color ' '
_set fake_tide_right_prompt_item_separator_diff_color ' '
_set fake_tide_right_prompt_pad_separators false
_set fake_tide_right_prompt_suffix ''
# ---------Prompt Connection---------
_set fake_tide_prompt_connection_color 6C6C6C
_set fake_tide_prompt_connection_icon ' '

# --------------------Prompt Items--------------------
# ------------Prompt Char------------
_set fake_tide_prompt_char_success_color $_tide_color_green
_set fake_tide_prompt_char_failure_color FF0000
_set fake_tide_prompt_char_icon '❯'
_set fake_tide_prompt_char_bg_color normal
# ----------------Pwd----------------
_set fake_tide_pwd_truncate_margin 10
_set fake_tide_pwd_unwritable_icon '' # Lock
_set fake_tide_pwd_max_dirs 0
_set fake_tide_pwd_anchors 'first' 'last' 'git'
_set fake_tide_pwd_color_anchors $_tide_color_light_blue
_set fake_tide_pwd_color_dirs $_tide_color_dark_blue
_set fake_tide_pwd_color_truncated_dirs 8787AF
_set fake_tide_pwd_bg_color normal
# ------------Git prompt------------
_set fake___fish_git_prompt_show_informative_status true
_set fake___fish_git_prompt_showstashstate true
_set fake_tide_git_prompt_bg_color normal
# -------Symbols-------
_set fake___fish_git_prompt_char_stateseparator ''
_set fake___fish_git_prompt_char_cleanstate ''
_set fake___fish_git_prompt_char_upstream_ahead ' ⇡'
_set fake___fish_git_prompt_char_upstream_behind ' ⇣'
_set fake___fish_git_prompt_char_stagedstate ' +'
_set fake___fish_git_prompt_char_dirtystate ' !'
_set fake___fish_git_prompt_char_untrackedfiles ' ?'
_set fake___fish_git_prompt_char_stashstate ' *'
# --------Colors--------
_set fake___fish_git_prompt_color_branch $_tide_color_green
_set fake___fish_git_prompt_color_upstream $_tide_color_green
_set fake___fish_git_prompt_color_stagedstate $tideColorGold
_set fake___fish_git_prompt_color_dirtystate $tideColorGold
_set fake___fish_git_prompt_color_untrackedfiles $_tide_color_light_blue
_set fake___fish_git_prompt_color_stashstate $_tide_color_green
# --------------Status--------------
_set fake_tide_status_success_icon '✔'
_set fake_tide_status_success_color $tideColorDarkerGreen
_set fake_tide_status_failure_icon '✘'
_set fake_tide_status_failure_color D70000
_set fake_tide_status_bg_color normal
# -----------Cmd_Duration-----------
_set fake_tide_cmd_duration_color 87875F
_set fake_tide_cmd_duration_decimals 0
_set fake_tide_cmd_duration_threshold 3000
_set fake_tide_cmd_duration_bg_color normal
# --------------Context--------------
_set fake_tide_context_ssh_color D7AF87
_set fake_tide_context_root_color $tideColorGold
_set fake_tide_context_bg_color normal
# ---------------Jobs---------------
_set fake_tide_jobs_icon '' # Gear
_set fake_tide_jobs_color $tideColorDarkerGreen
_set fake_tide_jobs_bg_color normal
# ---------------Virtual_Env---------------
_set fake_tide_virtual_env_color 00AFAF
_set fake_tide_virtual_env_display 'projectName'
_set fake_tide_virtual_env_icon ''
# ---------------Time---------------
_set fake_tide_time_color 5F8787
_set fake_tide_time_format '%T'
_set fake_tide_time_bg_color normal