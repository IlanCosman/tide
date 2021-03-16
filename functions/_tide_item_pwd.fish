function _tide_item_pwd
    set -l colorDirs (set_color $tide_pwd_color_dirs || echo)
    set -l colorAnchors (set_color -o $tide_pwd_color_anchors || echo)
    set -l keepBackgroundColor (set_color normal -b $tide_pwd_bg_color || echo)
    set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs || echo)

    set -l splitPwd (string replace -- $HOME '~' $PWD | string split --no-empty '/')
    set -l splitPwdForLength $splitPwd
    set -l splitPwdForOutput $splitPwd
    # Anchor first and last directories
    set splitPwdForOutput[1] $colorAnchors"$splitPwd[1]"$keepBackgroundColor$colorDirs
    set splitPwdForOutput[-1] $colorAnchors"$splitPwd[-1]"$keepBackgroundColor$colorDirs

    set -l pwdMaxLength (math $COLUMNS -$tide_pwd_truncate_margin)

    set -l i 1
    for dirSection in $splitPwd[2..-2]
        set -l parentDir (string join -- '/' $splitPwd[1..$i] | string replace '~' $HOME) # Use i from before increment

        set i (math $i + 1) # This keeps us from using seq

        # Returns true if any markers exist in dirSection
        if test -z false (string split --max 2 " " -- "-o -e "$parentDir/$dirSection/$tide_pwd_markers)
            set splitPwdForOutput[$i] $colorAnchors$dirSection$keepBackgroundColor$colorDirs
        else if test (string join -- '/' $splitPwdForLength | string length) -gt $pwdMaxLength
            while set -l truncationLength (math $truncationLength + 1) &&
                    set -l truncated (string sub --length $truncationLength -- $dirSection) &&
                    test $truncated != $dirSection -a (count $parentDir/$truncated*/) -gt 1
            end

            set splitPwdForLength[$i] $truncated
            set splitPwdForOutput[$i] $colorTruncatedDirs$truncated$keepBackgroundColor$colorDirs
        end
    end

    # All the actual printing
    if not test -w $PWD
        printf '%s' $colorDirs $tide_pwd_unwritable_icon' '
    else if test $PWD = $HOME
        printf '%s' $colorDirs $tide_pwd_home_icon' '
    else
        printf '%s' $colorDirs $tide_pwd_dir_icon' '
    end

    test "$splitPwd[1]" = '~' || printf '%s' /

    string join -- / $splitPwdForOutput
end
