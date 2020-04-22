function lean_right_prompt
    set -l norm (set_color normal)
    set -l ltc (set_color $lean_timer_color)

    set -l leanRightPrompt " "$ltc$leanTimer$norm" "
    echo $leanRightPrompt
end