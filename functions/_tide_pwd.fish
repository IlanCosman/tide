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

        if false || for marker in $tide_pwd_markers # false is for if tide_pwd_markers is empty
                test -e $parent_dir/$dir_section/$marker && break
            end
            set split_output[$i] $_tide_color_anchors$dir_section$_tide_reset_to_color_dirs
        else if test $pwd_length -gt $dist_btwn_sides
            set -l trunc
            while string match -qr "(?<trunc>$trunc.)" $dir_section && test (count $parent_dir/$trunc*/) != 1
            end
            test -n "$trunc" && set split_output[$i] $_tide_color_truncated_dirs$trunc$_tide_reset_to_color_dirs &&
                string join / $split_output | string length --visible | read -g pwd_length
        end
    end

    string join -- / $split_output
end
