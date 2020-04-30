function lean_pwd
    set -l pwdSplit (string split --no-empty '/' (_shorten_pwd))
    set -l pwdSplitLength (count $pwdSplit)

    if not test -w $PWD
        set_color $lean_color_dark_blue
        echo -n {$lean_pwd_unwritable_icon}' '
        set_color $fish_color_normal
    end

    if test "$pwdSplit[1]" != '~'
        set_color $lean_color_dark_blue
        echo -n '/'
        set_color $fish_color_normal
    end

    set_color -o $lean_color_light_blue
    echo -n $pwdSplit[1]
    set_color $fish_color_normal

    if test $pwdSplitLength -gt 1
        set_color $lean_color_dark_blue
        echo -n '/'
        set_color $fish_color_normal
    end

    if test $pwdSplitLength -gt 2
        set_color $lean_color_dark_blue
        echo -n (string join '/' $pwdSplit[2..-2])'/'
        set_color $fish_color_normal
    end

    if test $pwdSplitLength -gt 1
        set_color -o $lean_color_light_blue
        echo -n $pwdSplit[-1]
        set_color $fish_color_normal
    end
end

function _shorten_pwd
    set -l pwd (prompt_pwd)

    if test "$pwd" = "$previousPwd"
        echo $pwd
        return
    end

    set -g fish_prompt_pwd_dir_length 0
    set -l pwd (prompt_pwd)
    set -l lengthPromptPwd (string length $pwd)
    set -l shortenPwdLength (math $COLUMNS-$lean_pwd_shorten_margin)

    set -l promptPwdDirLength 8
    while test $lengthPromptPwd -gt $shortenPwdLength -a $promptPwdDirLength -gt 0
        set fish_prompt_pwd_dir_length $promptPwdDirLength
        set pwd (prompt_pwd)
        set lengthPromptPwd (string length $pwd)
        set promptPwdDirLength (math $promptPwdDirLength-1)
    end

    set -g previousPwd (prompt_pwd)

    echo $pwd
end