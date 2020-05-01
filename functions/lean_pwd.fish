function lean_pwd
    set -l splitPwd (string split --no-empty '/' (_shorten_pwd))
    set -l splitPwdLength (count $splitPwd)

    if not test -w $PWD
        set_color $lean_color_dark_blue
        echo -n {$lean_pwd_unwritable_icon}' '
        set_color $fish_color_normal
    end

    if test "$splitPwd[1]" != '~'
        set_color $lean_color_dark_blue
        echo -n '/'
        set_color $fish_color_normal
    end

    set_color -o $lean_color_light_blue
    echo -n $splitPwd[1]
    set_color $fish_color_normal

    if test $splitPwdLength -gt 1
        set_color $lean_color_dark_blue
        echo -n '/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 2
        set_color $lean_color_dark_blue
        echo -n (string join '/' $splitPwd[2..-2])'/'
        set_color $fish_color_normal
    end

    if test $splitPwdLength -gt 1
        set_color -o $lean_color_light_blue
        echo -n $splitPwd[-1]
        set_color $fish_color_normal
    end
end

function _shorten_pwd
    set -l pwd (string replace $HOME '~' (pwd))
    set -l splitPwd (string split --no-empty '/' $pwd)

    set -l pwdLength (string length $pwd)
    set -l shortenPwdLength (math $COLUMNS-$lean_pwd_shorten_margin)

    set -l index 1
    while test $pwdLength -gt $shortenPwdLength
        set splitPwd[$index] (string sub -l 1 $splitPwd[$index])
        set pwd (string join '/' $splitPwd)
        set pwdLength (string length $pwd)
        set index (math $index+1)
    end

    echo $pwd
end