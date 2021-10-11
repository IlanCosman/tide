function _tide_item_userhost
    _tide_print_item userhost $tide_cmd_duration_icon' ' (set_color yellow; printf '%s@' $USER; set_color --bold yellow; printf '%s' $hostname)
end
