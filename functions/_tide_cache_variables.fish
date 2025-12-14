function _tide_cache_variables
    # Same-color-separator color
    set_color $tide_prompt_color_separator_same_color | read -g _tide_color_separator_same_color

    # git
    contains git $_tide_left_items $_tide_right_items && set_color $tide_git_color_branch | read -g _tide_location_color

    # private_mode
    if contains private_mode $_tide_left_items $_tide_right_items && test -n "$fish_private_mode"
        set -g _tide_private_mode
    else
        set -e _tide_private_mode
    end

    # item padding
    test "$tide_prompt_pad_items" = true && set -g _tide_pad ' ' || set -e _tide_pad
end
