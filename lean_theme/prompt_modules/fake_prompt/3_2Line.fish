    set_color $fake_lean_prompt_connection_color
    printf "%.s$fake_lean_prompt_connection" (seq $columns)
    set_color $fish_color_normal
    
    set -l timerOutput " 5s "
    set -l timerStartLocation (math $columns-(string length $timerOutput))
    printf "\r\033["$timerStartLocation"C"
    set_color $lean_timer_color
    echo -n $timerOutput
    set_color $fish_color_normal
    
    echo -ne "\r"
    
    set -l Lblue (set_color -o $lean_color_light_blue)
    set -l Dblue (set_color $lean_color_dark_blue)
    set -l n (set_color $fish_color_normal)
    echo -n $Lblue"~"$n$Dblue"/"$n$Lblue"src "$n
    
    set_color $lean_color_green
    echo "master "
    set_color $fish_color_normal