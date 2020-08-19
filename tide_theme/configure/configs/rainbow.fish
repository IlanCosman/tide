# -------------------Local Variables-------------------
set -l tideColorGold D7AF00
set -l tideColorDarkerGreen 5FAF00

# ---------------General Theme Variables---------------
_set fake_tide_print_newline_before_prompt 'true'
# ------------Left Prompt------------
_set fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline'
_set fake_tide_left_prompt_pad_items true

_set fake_tide_left_prompt_item_separator_same_color ''
_set fake_tide_left_prompt_item_separator_diff_color ''

_set fake_tide_left_prompt_item_separator_same_color_color 949494

_set fake_tide_left_prompt_prefix ''
_set fake_tide_left_prompt_suffix ''

_set fake_tide_left_prompt_frame_enabled true
_set fake_tide_left_prompt_frame_color 6C6C6C
# ------------Right Prompt------------
_set fake_tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs' 'virtual_env'
_set fake_tide_right_prompt_pad_items true

_set fake_tide_right_prompt_item_separator_same_color ''
_set fake_tide_right_prompt_item_separator_diff_color ''

_set fake_tide_right_prompt_item_separator_same_color_color 949494

_set fake_tide_right_prompt_prefix ''
_set fake_tide_right_prompt_suffix ''

_set fake_tide_right_prompt_frame_enabled true
_set fake_tide_right_prompt_frame_color 6C6C6C
# ---------Prompt Connection---------
_set fake_tide_prompt_connection_color 6C6C6C
_set fake_tide_prompt_connection_icon ''

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
_set fake_tide_pwd_color_anchors E4E4E4
_set fake_tide_pwd_color_dirs E4E4E4
_set fake_tide_pwd_color_truncated_dirs BCBCBC
_set fake_tide_pwd_bg_color blue
# ------------Git prompt------------
_set fake___fish_git_prompt_show_informative_status true
_set fake___fish_git_prompt_showstashstate true
_set fake_tide_git_prompt_bg_color 4E9A06
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
_set fake___fish_git_prompt_color_branch 000000
_set fake___fish_git_prompt_color_upstream 000000
_set fake___fish_git_prompt_color_stagedstate 000000
_set fake___fish_git_prompt_color_dirtystate 000000
_set fake___fish_git_prompt_color_untrackedfiles 000000
_set fake___fish_git_prompt_color_stashstate 000000
# --------------Status--------------
_set fake_tide_status_always_display false
_set fake_tide_status_success_icon '✔'
_set fake_tide_status_success_color 4E9A06
_set fake_tide_status_success_bg_color 2E3436
_set fake_tide_status_failure_icon '✘'
_set fake_tide_status_failure_color FFFF00
_set fake_tide_status_failure_bg_color CC0000
# -----------Cmd_Duration-----------
_set fake_tide_cmd_duration_color 000000
_set fake_tide_cmd_duration_decimals 0
_set fake_tide_cmd_duration_threshold 3000
_set fake_tide_cmd_duration_bg_color C4A000
# --------------Context--------------
_set fake_tide_context_ssh_color D7AF87
_set fake_tide_context_root_color $tideColorGold
_set fake_tide_context_always_display false
_set fake_tide_context_default_color D7AF87
_set fake_tide_context_bg_color 444444
# ---------------Jobs---------------
_set fake_tide_jobs_icon '' # Gear
_set fake_tide_jobs_color 4E9A06
_set fake_tide_jobs_bg_color 444444
# ---------------Virtual_Env---------------
_set fake_tide_virtual_env_color 00AFAF
_set fake_tide_virtual_env_display_mode 'projectName'
_set fake_tide_virtual_env_icon ''
_set fake_tide_virtual_env_bg_color 444444
# ---------------Time---------------
_set fake_tide_time_color 000000
_set fake_tide_time_format '%T'
_set fake_tide_time_bg_color D3D7CF
# ---------------OS---------------
_set fake_tide_os_color 080808
_set fake_tide_os_bg_color CED7CF
_set fake_tide_os_use_nearest true
# ---------------Rust---------------
_set fake_tide_rust_color 2E3436
_set fake_tide_rust_bg_color FF8700
_set fake_tide_rust_icon ''
_set fake_tide_rust_verbose_version false