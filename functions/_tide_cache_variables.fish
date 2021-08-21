function _tide_cache_variables
    # pwd
    set -gx _tide_color_anchors (set_color -o $tide_pwd_color_anchors)
    set -gx _tide_color_truncated_dirs (set_color $tide_pwd_color_truncated_dirs || echo)
    set -gx _tide_reset_to_color_dirs (set_color normal -b $tide_pwd_bg_color; set_color $tide_pwd_color_dirs)

    # git
    contains git $tide_left_prompt_items $tide_right_prompt_items &&
        set -gx _tide_location_color (set_color $tide_git_color_branch || echo)

    # two line prompt
    contains newline $tide_left_prompt_items &&
        set -gx _tide_prompt_and_frame_color (set_color $tide_prompt_color_frame_and_connection -b normal)

    # newline before
    set -e _tide_add_newline
    test "$tide_prompt_add_newline_before" = true && set -g _tide_add_newline ''
end
