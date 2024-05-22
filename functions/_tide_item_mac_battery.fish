function _tide_item_mac_battery
    set -l info (pmset -g batt | awk 'NR==2 {gsub(/;/,""); print $3 " " $4}')
    set -l percent (string match -rg '(\d+)%\s*\w+' $info)
    set -l state (string match -rg '\d+%\s*(\w+)' $info)
    set -l icons $tide_mac_battery_icons
    set -l colors $tide_mac_battery_colors

    # icons = [0%, 10%, 20%, 30%, 40%, 50%, 60%, 70%, 80%, 90%, 100%, charging]
    # colors = [low, normal, charging]

    if test $state != discharging # plugged in, either charging or charged
        set -f icon $icons[12]
    else
        set -l icon_type (math round $percent / 10)
        set -l icon_idx (math $icon_type + 1)

        set -f icon $icons[$icon_idx]
    end

    if test $state != discharging
        set_color $colors[3]
    else if test $percent -le 20
        set_color $colors[1]
    else
        set_color $colors[2]
    end

    printf ' %s %s%%' $icon $percent
    set_color normal
end
