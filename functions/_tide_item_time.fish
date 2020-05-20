function _tide_item_time
    set_color $tide_time_color
    printf '%s ' (date +$tide_time_format)
end