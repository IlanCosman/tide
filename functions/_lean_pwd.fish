function _lean_pwd
    set -l splitPwd (string split --no-empty '/' (_shorten_pwd))
    set -l splitPwdLength (count $splitPwd)

    if not test -w $PWD
        set_color $lean_color_dark_blue
        printf {$lean_pwd_unwritable_icon}' '
        set_color $fish_color_normal
    end

    if test "$splitPwd[1]" != '~'
        set_color $lean_color_dark_blue
        printf '/'
        set_color $fish_color_normal
    end

    set_color -o $lean_color_light_blue
    printf "$splitPwd[1]"
    set_color $fish_color_normal

    if test $splitPwdLength -gt 1
        set_color $lean_color_dark_blue
        printf '/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 2
        set_color $lean_color_dark_blue
        printf (string join '/' $splitPwd[2..-2])'/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 1
        set_color -o $lean_color_light_blue
        printf "$splitPwd[-1]"
        set_color $fish_color_normal
    end

    printf ' '
end

function _shorten_pwd
    set -l pwd (string replace $HOME '~' $PWD)
    set -l colorPwd $pwd
    set -l splitPwd (string split --no-empty '/' $pwd)
    set -l targetLength (math $COLUMNS-$lean_pwd_shorten_margin)

    set -l index 2
    while test (string length $pwd) -gt $targetLength
        set -l currentPart $splitPwd[$index]
        set -l currentPartFirstLetter (string sub -l 1 $currentPart)
        set pwd (string replace $currentPart $currentPartFirstLetter $pwd)

        set -l lilac (set_color $lean_color_lilac)
        set -l dBlue (set_color $lean_color_dark_blue)
        set colorPwd (string replace $currentPart "$lilac"$currentPartFirstLetter"$dBlue" $colorPwd)

        set index (math $index+1)
    end

    printf "$colorPwd"
end