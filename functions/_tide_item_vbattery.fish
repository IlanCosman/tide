function _tide_item_vbattery
    switch $tide_battery_method
        case termux
            set -l termux_bat_out (termux-battery-status)
            set -f bat_capacity (string match -rg 'percentage": ([0-9]*)' $termux_bat_out)
            set -f bat_status (string match -rg '"status": "([^"]*)"' $termux_bat_out)
        case sysfs
            if set -q tide_battery_sysfs_name
                set -f bat_capacity (cat /sys/class/power_supply/$tide_battery_sysfs_name/capacity)
                set -f bat_status (cat /sys/class/power_supply/$tide_battery_sysfs_name/status)
            else
                set -l battery_name /sys/class/power_supply/BAT*
                if count $battery_name >/dev/null
                    set -f bat_capacity (cat $battery_name/capacity)[1]
                    set -f bat_status (cat $battery_name/status)[1]
                end
            end
        case '*'
            set -l upower_out (upower -b)
            set -f bat_capacity (string match -rg 'percentage: *([0-9]*)' $upower_out)
            set -f bat_status (string match -rg 'state: *(.*)' $upower_out)
    end

    test -n "$bat_capacity" || return

    switch (string lower $bat_status)
        case 'not charging' 'fully charged'
            _tide_print_item vbattery '󰁹'
            return
        case charging
            #                        0-4 5-14 15-24 25-34 35-44 45-54 55-64 65-74 75-84 85-94 95-100
            set -f battery_symbols '󰢟' '󰢜' '󰂆' '󰂇' '󰂈' '󰢝' '󰂉' '󰢞' '󰂊' '󰂋' '󰂅'
        case discharging
            set -f battery_symbols '󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹'
            if test $bat_capacity -lt $tide_battery_critical_threshold
                set -fx tide_battery_color $tide_battery_color_critical
            else if test $bat_capacity -lt $tide_battery_low_threshold
                set -fx tide_battery_color $tide_battery_color_low
            end
        case '*'
            _tide_print_item vbattery '󰂑'
            return
    end

    set -l symbol_index (math -s0 -m round "$bat_capacity / 10 + 1")
    set -l battery_symbol $battery_symbols[$symbol_index]

    _tide_print_item vbattery $battery_symbol
end
