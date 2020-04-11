function lean_pwd
    set pwdSplit (string split "/" (_shorten_pwd))
    set pwdSplitLength (count $pwdSplit)

    if test $pwdSplit[1] != "~"
        set_color -o $lean_light_blue
        echo -n "/"
        set_color $fish_color_normal
    else
        set_color -o $lean_light_blue
        echo -n $pwdSplit[1]
        set_color $fish_color_normal

        if test $pwdSplitLength -gt 1
            set_color $lean_dark_blue
            echo -n "/"
            set_color $fish_color_normal
        end
    end

    set_color $lean_dark_blue
    echo -n (string join "/" $pwdSplit[2..-2])
    if test $pwdSplitLength -gt 2
        echo -n "/"
    end
    set_color $fish_color_normal

    set_color -o $lean_light_blue
    if test $pwdSplitLength -gt 1
        echo -n $pwdSplit[-1]
    end
    set_color $fish_color_normal
end

function _shorten_pwd
    set fish_prompt_pwd_dir_length 0
    set lengthPromptPwd (string length (prompt_pwd))
    set shortenPwdLength (math $COLUMNS-$lean_shorten_pwd_margin)

    if test $lengthPromptPwd -gt $shortenPwdLength
        set smallestAbsoluteDiff $lengthPromptPwd

        for promptPwdDirLength in 4 5 6 7 8 9 10 0
            set fish_prompt_pwd_dir_length $promptPwdDirLength
            set lengthPromptPwd (string length (prompt_pwd))

            if test $lengthPromptPwd -lt $shortenPwdLength
                set absoluteDiff (math "abs($shortenPwdLength-$lengthPromptPwd)")

                if test $absoluteDiff -lt $smallestAbsoluteDiff
                    set smallestAbsoluteDiff $absoluteDiff
                    set bestPromptPwdDirLength $promptPwdDirLength
                end
            end
        end

        set fish_prompt_pwd_dir_length $bestPromptPwdDirLength
    end

    echo (prompt_pwd)
end