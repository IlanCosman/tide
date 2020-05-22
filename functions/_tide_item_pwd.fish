function _tide_item_pwd
    set -l splitPwd (string split --no-empty '/' (_truncate_pwd))
    set -l splitPwdLength (count $splitPwd)

    if not test -w $PWD
        set_color $tide_pwd_color_mid_dirs
        printf '%s' {$tide_pwd_unwritable_icon}' '
        set_color $fish_color_normal
    end

    if test "$splitPwd[1]" != '~'
        set_color $tide_pwd_color_mid_dirs
        printf '%s' '/'
        set_color $fish_color_normal
    end

    set_color -o $tide_pwd_color_end_dirs
    printf '%s' "$splitPwd[1]"
    set_color $fish_color_normal

    if test $splitPwdLength -gt 1
        set_color $tide_pwd_color_mid_dirs
        printf '%s' '/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 2
        set_color $tide_pwd_color_mid_dirs
        printf '%s' (string join '/' $splitPwd[2..-2])'/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 1
        set_color -o $tide_pwd_color_end_dirs
        printf '%s' "$splitPwd[-1]"
        set_color $fish_color_normal
    end

    printf '%s' ' '
end

function _truncate_pwd
    set -l pwd (string replace $HOME '~' $PWD)
    set -l colorPwd $pwd
    set -l splitPwd (string split --no-empty '/' $pwd)
    set -l maxLength (math $COLUMNS-$tide_pwd_truncate_margin)

    if test (string length $pwd) -gt $maxLength
        for dir in $splitPwd[2..-2]
            set -l dirTruncated (string sub -l 1 $dir)
            if test $dirTruncated = '.'
                set dirTruncated (string sub -l 2 $dir)
            end

            set pwd (string replace $dir $dirTruncated $pwd)

            set -l lilac (set_color $tide_pwd_color_truncated_dirs)
            set -l dBlue (set_color $tide_pwd_color_mid_dirs)
            set colorPwd (string replace $dir "$lilac"$dirTruncated"$dBlue" $colorPwd)

            if test (string length $pwd) -lt $maxLength
                break
            end
        end
    end

    printf '%s' "$colorPwd"
end