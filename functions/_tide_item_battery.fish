function _tide_item_battery
    _tide_print_item battery $tide_battery_icon " " (cat /sys/class/power_supply/BAT0/capacity) "%"
end
