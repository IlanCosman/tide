    printf '%.s ' (seq $columns)
    
    set -l cmd_durationOutput ' 5s '
    set -l cmd_durationStartLocation (math $columns-(string length $cmd_durationOutput))
    printf '\r\033['$cmd_durationStartLocation'C'
    set_color $lean_cmd_duration_color
    echo -n $cmd_durationOutput
    set_color $fish_color_normal
    
    echo -ne '\r'
    
    set -l Lblue (set_color -o $lean_color_light_blue)
    set -l Dblue (set_color $lean_color_dark_blue)
    set -l n (set_color $fish_color_normal)
    echo -n $Lblue'~'$n$Dblue'/'$n$Lblue'src '$n
    
    set_color $lean_color_green
    echo -n 'master '
    set_color $fish_color_normal