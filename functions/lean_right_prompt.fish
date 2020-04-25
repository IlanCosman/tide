function lean_right_prompt
    echo -n " "
    if test -n "$leanTimer"
        set_color $lean_timer_color
        echo -n $leanTimer
        set_color normal
        echo -n " "
    end
    if test -n "$leanSSH"
        set_color $lean_ssh_color
        echo -n $leanSSH
        set_color normal
        echo -n " "
    end
end