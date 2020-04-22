function lean_pwd
    set -l pwdSplit (string split "/" (_shorten_pwd))
    set -l pwdSplitLength (count $pwdSplit)

    if test $pwdSplit[1] = "~"
        set_color -o $lean_color_light_blue
        echo -n "~"
        set_color $fish_color_normal

        if test $pwdSplitLength -gt 1
            set_color $lean_color_dark_blue
            echo -n "/"
            set_color $fish_color_normal
        end
    else
        set_color $lean_color_dark_blue
        echo -n "/"
        set_color $fish_color_normal
    end

    set_color $lean_color_dark_blue
    echo -n (string join "/" $pwdSplit[2..-2])
    if test $pwdSplitLength -gt 2
        echo -n "/"
    end
    set_color $fish_color_normal

    set_color -o $lean_color_light_blue
    if test $pwdSplitLength -gt 1
        echo -n $pwdSplit[-1]
    end
    set_color $fish_color_normal
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
    set -l shortenPwdLength (math $COLUMNS-$lean_shorten_pwd_margin)

    if test $lengthPromptPwd -gt $shortenPwdLength
        for promptPwdDirLength in 8 7 6 5 4 3
            set fish_prompt_pwd_dir_length $promptPwdDirLength
            set pwd (prompt_pwd)
            set lengthPromptPwd (string length $pwd)

            if test $lengthPromptPwd -lt $shortenPwdLength
                break
            end
        end
    end

    set -g previousPwd (prompt_pwd)

    echo $pwd
end