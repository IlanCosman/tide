    printf '%.s ' (seq $columns)
    
    set -l rightPrompt ' 5s '(date +$fake_lean_time_format)
    set -l rightPromptStartLocation (math $columns-(string length $rightPrompt))
    printf '\r\033['$rightPromptStartLocation'C'
    set_color $lean_cmd_duration_color
    echo -n ' 5s '
    set_color $fish_color_normal
    set_color $lean_time_color
    echo -n (date +$fake_lean_time_format)
    set_color $fish_color_normal
    
    echo -ne '\r'
    
    set -l Lblue (set_color -o $lean_color_light_blue)
    set -l Dblue (set_color $lean_color_dark_blue)
    set -l n (set_color $fish_color_normal)
    echo -n $Lblue'~'$n$Dblue'/'$n$Lblue'src '$n
    
    set_color $lean_color_green
    echo -n 'master '
    set_color $fish_color_normal