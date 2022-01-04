function _tide_cache_variables
    # pwd
    set -l data (
        # pwd
        set_color -o $tide_pwd_color_anchors
        echo
        set_color $tide_pwd_color_truncated_dirs
        echo
        set_color normal -b $tide_pwd_bg_color; set_color $tide_pwd_color_dirs
        echo
        # Same-color-separator color
        set_color $tide_prompt_color_separator_same_color
        echo
        # git
        set_color $tide_git_color_branch
    )

    # pwd
    set -g _tide_color_anchors "$data[1]"
    set -g _tide_color_truncated_dirs "$data[2]"
    set -g _tide_reset_to_color_dirs "$data[3]"

    # Same-color-separator color
    set -gx _tide_color_separator_same_color "$data[4]"

    # git
    contains git $_tide_left_items $_tide_right_items && set -gx _tide_location_color "$data[5]"

    # private_mode
    if contains private_mode $_tide_left_items $_tide_right_items && test -n "$fish_private_mode"
        set -gx _tide_private_mode
    else
        set -e _tide_private_mode
    end

    # item padding
    test "$tide_prompt_pad_items" = true && set -gx _tide_pad ' ' || set -e _tide_pad
end
