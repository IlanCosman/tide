function _lean_right_prompt_nocolor
    echo -n ' '
    if test -n "$leanTimer"
        echo -n $leanTimer
        echo -n ' '
    end
end
