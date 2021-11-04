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
    test -n "$split_pwd[1]" && # ~/foo/bar, hightlight ~   OR   /foo/bar, hightlight foo not empty string
        set -l split_output "$_tide_reset_to_color_dirs$icon"$_tide_color_anchors$split_pwd[1]$_tide_reset_to_color_dirs $split_pwd[2..] ||
        set -l split_output "$_tide_reset_to_color_dirs$icon" $_tide_color_anchors$split_pwd[2]$_tide_reset_to_color_dirs $split_pwd[3..]
    set split_output[-1] $_tide_color_anchors$split_pwd[-1]$_tide_reset_to_color_dirs

    string join / $split_output | string length --visible | read -g pwd_length

    i=1 for dir_section in $split_pwd[2..-2]
        string join -- / $split_pwd[..$i] | string replace '~' $HOME | read -l parent_dir # Uses i before increment

        math $i+1 | read i

        # Returns true if any markers exist in dir_section
        if test -z false (string split --max 2 " " -- "-o -e $parent_dir/$dir_section/"$tide_pwd_markers)
            set split_output[$i] $_tide_color_anchors$dir_section$_tide_reset_to_color_dirs
        else if test $pwd_length -gt $dist_btwn_sides
            string sub --length 1 -- $dir_section | read -l trunc
            trunc_len=1 while test $trunc != $dir_section -a (count $parent_dir/$trunc*/) != 1
                math $trunc_len+1 | read trunc_len
                string sub --length $trunc_len -- $dir_section | read trunc
            end
            if test $trunc != $dir_section
                set split_output[$i] $_tide_color_truncated_dirs$trunc$_tide_reset_to_color_dirs
                string join / $split_output | string length --visible | read -g pwd_length
            end
        end
    end

    string join -- / $split_output
end
