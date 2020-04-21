function lean_right_prompt
    set -l n (set_color normal)
    set -l ltc (set_color $lean_timer_color)

    set -l leanRightPrompt " "$ltc$leanTimer$n" "
    echo $leanRightPrompt
end