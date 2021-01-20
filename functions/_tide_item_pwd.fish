function _tide_item_pwd
    set -l splitPwd (string replace $HOME '~' $PWD | string split --no-empty '/')
    set -l splitPwdForLength $splitPwd
    set -l splitPwdForOutput $splitPwd

    contains first $tide_pwd_anchors && set -la anchorDirs 1
    contains last $tide_pwd_anchors && set -la anchorDirs (count $splitPwd)

    set -l colorDirs (set_color $tide_pwd_color_dirs || echo)
    set -l colorAnchors (set_color -o $tide_pwd_color_anchors || echo)
    set -l keepBackgroundColor (set_color normal -b $tide_pwd_bg_color || echo)
    set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs || echo)

    if not test -w $PWD
        printf '%s' $colorDirs $tide_pwd_unwritable_icon' '
    else if test $PWD = $HOME
        printf '%s' $colorDirs $tide_pwd_home_icon' '
    else
        printf '%s' $colorDirs $tide_pwd_dir_icon' '
    end

    set -l pwdMaxLength (math $COLUMNS -$tide_pwd_truncate_margin)

    for i in (seq (count $splitPwd))
        set -l parentDir (string join '/' $splitPwd[1..(math $i-1)] | string replace '~' $HOME)

        # Returns true if any markers exist in splitPwd[$i], or if anchorDirs contains i
        if test -z false (string split -m 2 " " -- "-o -e "$parentDir/$tide_pwd_markers) || contains $i $anchorDirs
            set splitPwdForOutput[$i] $colorAnchors$splitPwd[$i]$keepBackgroundColor$colorDirs
        else if test (string join '/' $splitPwdForLength | string length) -gt $pwdMaxLength
            set -l truncationLength 1
            while set -l truncated (string sub --length $truncationLength $splitPwd[$i])
                test (string length $truncated) -lt (string length $splitPwdForLength[$i]) || break
                test (count $parentDir/$truncated*/) -gt 1 || break

                set truncationLength (math $truncationLength + 1)
            end

            set splitPwdForLength[$i] $truncated
            set splitPwdForOutput[$i] $colorTruncatedDirs$truncated$keepBackgroundColor$colorDirs
        end
    end

    test "$splitPwd[1]" = '~' || printf '%s' '/'

    string join '/' $splitPwdForOutput
end