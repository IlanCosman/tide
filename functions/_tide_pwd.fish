function _tide_pwd
    set -l color_anchors (set_color -o $tide_pwd_color_anchors)
    set -l color_truncated_dirs (set_color $tide_pwd_color_truncated_dirs || echo)
    set -l reset_to_color_dirs (set_color normal -b $tide_pwd_bg_color; set_color $tide_pwd_color_dirs)

    set -l split_pwd (string replace -- $HOME '~' $PWD | string split /)
    set -l split_pwd_for_length $split_pwd

    # Anchor first and last directories (which may be the same)
    if test -n "$split_pwd[1]" # ~/foo/bar, hightlight ~
        set split_pwd_for_output $color_anchors$split_pwd[1]$reset_to_color_dirs $split_pwd[2..]
    else # /foo/bar, hightlight foo not empty string
        set split_pwd_for_output '' $color_anchors$split_pwd[2]$reset_to_color_dirs $split_pwd[3..]
    end
    set split_pwd_for_output[-1] $color_anchors$split_pwd[-1]$reset_to_color_dirs

    if not test -w $PWD
        set -g tide_pwd_icon $tide_pwd_icon_unwritable' '
    else if test $PWD = $HOME
        set -g tide_pwd_icon $tide_pwd_icon_home' '
    else
        set -g tide_pwd_icon $tide_pwd_icon' '
    end

    set -g pwd_length (string length "$tide_pwd_icon"(string join / $split_pwd_for_length))

    i=1 for dir_section in $split_pwd[2..-2]
        set -l parent_dir (string join -- / $split_pwd[..$i] | string replace '~' $HOME) # Uses i before increment

        set i (math $i + 1)

        # Returns true if any markers exist in dir_section
        if test -z false (string split --max 2 " " -- "-o -e "$parent_dir/$dir_section/$tide_pwd_markers)
            set split_pwd_for_output[$i] $color_anchors$dir_section$reset_to_color_dirs
        else if test $pwd_length -gt $dist_btwn_sides
            while set -l truncation_length (math $truncation_length + 1) &&
                    set -l truncated (string sub --length $truncation_length -- $dir_section) &&
                    test $truncated != $dir_section -a (count $parent_dir/$truncated*/) -gt 1
            end
            set split_pwd_for_length[$i] $truncated
            set split_pwd_for_output[$i] $color_truncated_dirs$truncated$reset_to_color_dirs
            set pwd_length (string length "$tide_pwd_icon"(string join / $split_pwd_for_length)) # Update length
        end
    end

    printf '%s' $reset_to_color_dirs $tide_pwd_icon
    string join -- / $split_pwd_for_output
end
