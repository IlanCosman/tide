set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
set -g fake_tide_right_prompt_items

set -g fake_tide_prompt_connection_icon ''

set -g fake_tide_cmd_duration_color yellow

set -g fake_tide_pwd_color_end_dirs blue
set -g fake_tide_pwd_color_mid_dirs blue
set -g fake_tide_pwd_anchors

set -g fake_tide_prompt_char_success_color magenta
set -g fake_tide_prompt_char_failure_color red

set -e fake___fish_git_prompt_show_informative_status
set -g fake___fish_git_prompt_showupstream true
set -g fake___fish_git_prompt_showdirtystate true

set -g fake___fish_git_prompt_char_dirtystate '*'

set -g fake___fish_git_prompt_color_branch brblack
set -g fake___fish_git_prompt_color_upstream cyan
set -g fake___fish_git_prompt_color_dirtystate brblack