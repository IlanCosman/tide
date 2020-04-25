function lean_right_prompt
    echo -n " "
    if test -n "$leanTimer"
        set_color $lean_timer_color
        echo -n $leanTimer
        set_color normal
        echo -n " "
    end
end