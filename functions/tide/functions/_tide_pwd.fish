set_color -o $tide_pwd_color_anchors | read -l color_anchors
set_color $tide_pwd_color_truncated_dirs | read -l color_truncated
set -l reset_to_color_dirs (set_color normal -b $tide_pwd_bg_color; set_color $tide_pwd_color_dirs)

set -l unwritable_icon $tide_pwd_icon_unwritable'\ '
set -l home_icon $tide_pwd_icon_home'\ '
set -l pwd_icon $tide_pwd_icon'\ '

eval "function _tide_pwd
    if set -l split_pwd (string replace -r '^$HOME' '~' \$PWD | string split /)
        test -w . && set -f icon $pwd_icon || set -f icon $unwritable_icon
    else
        set -f icon $home_icon
    end

    # Anchor first and last directories (which may be the same)
    test -n \"\$split_pwd[1]\" && # ~/foo/bar, hightlight ~   OR   /foo/bar, hightlight foo not empty string
        set -l split_output \"$reset_to_color_dirs\$icon$color_anchors\$split_pwd[1]$reset_to_color_dirs\" \$split_pwd[2..] ||
        set -l split_output \"$reset_to_color_dirs\$icon\" \"$color_anchors\$split_pwd[2]$reset_to_color_dirs\" \$split_pwd[3..]
    set split_output[-1] \"$color_anchors\$split_output[-1]$reset_to_color_dirs\"

    string join / \$split_output | string length -V | read -g _tide_pwd_len

    i=1 for dir_section in \$split_pwd[2..-2]
        string join -- / \$split_pwd[..\$i] | string replace '~' $HOME | read -l parent_dir # Uses i before increment

        math \$i+1 | read i

        if false || for marker in $tide_pwd_markers # false is for if tide_pwd_markers is empty
                test -e \$parent_dir/\$dir_section/\$marker && break
            end
            set split_output[\$i] \"$color_anchors\$dir_section$reset_to_color_dirs\"
        else if test \$_tide_pwd_len -gt \$dist_btwn_sides
            set -l trunc
            while string match -qr \"(?<trunc>\$trunc.)\" \$dir_section && test (count \$parent_dir/\$trunc*/) != 1
            end
            test -n \"\$trunc\" && set split_output[\$i] \"$color_truncated\$trunc$reset_to_color_dirs\" &&
                string join / \$split_output | string length -V | read _tide_pwd_len
        end
    end

    string join -- / \$split_output
end"
