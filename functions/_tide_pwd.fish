function _tide_pwd
    set -l split_pwd (string replace -- $HOME '~' $PWD | string split /)

    if not test -w $PWD
        set -f icon $tide_pwd_icon_unwritable' '
    else if test $PWD = $HOME
        set -f icon $tide_pwd_icon_home' '
    else
        set -f icon $tide_pwd_icon' '
    end

    # Anchor first and last directories (which may be the same)
    if test -n "$split_pwd[1]" # ~/foo/bar, hightlight ~
        set -f split_pwd_for_output "$_tide_reset_to_color_dirs$icon"$_tide_color_anchors$split_pwd[1]$_tide_reset_to_color_dirs $split_pwd[2..]
    else # /foo/bar, hightlight foo not empty string
        set -f split_pwd_for_output "$_tide_reset_to_color_dirs$icon" $_tide_color_anchors$split_pwd[2]$_tide_reset_to_color_dirs $split_pwd[3..]
    end
    set split_pwd_for_output[-1] $_tide_color_anchors$split_pwd[-1]$_tide_reset_to_color_dirs

    string join / $split_pwd_for_output | string length --visible | read -g pwd_length

    i=1 for dir_section in $split_pwd[2..-2]
        string join -- / $split_pwd[..$i] | string replace '~' $HOME | read -l parent_dir # Uses i before increment

        math $i+1 | read i

        # Returns true if any markers exist in dir_section
        if test -z false (string split --max 2 " " -- "-o -e $parent_dir/$dir_section/"$tide_pwd_markers)
            set split_pwd_for_output[$i] $_tide_color_anchors$dir_section$_tide_reset_to_color_dirs
        else if test $pwd_length -gt $dist_btwn_sides
            while math $truncation_length +1 | read -l truncation_length &&
                    string sub --length $truncation_length -- $dir_section | read -l truncated &&
                    test $truncated != $dir_section
                if test (count $parent_dir/$truncated*/) = 1
                    set split_pwd_for_output[$i] $_tide_color_truncated_dirs$truncated$_tide_reset_to_color_dirs
                    string join / $split_pwd_for_output | string length --visible | read -g pwd_length
                    break
                end
            end
        end
    end

    string join -- / $split_pwd_for_output
end
