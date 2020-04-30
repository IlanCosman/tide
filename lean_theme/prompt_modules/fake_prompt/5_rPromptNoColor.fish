function _lean_right_prompt_nocolor
    echo -n ' '
    if test -n "$leancmd_duration"
        echo -n $leancmd_duration
        echo -n ' '
    end
end
