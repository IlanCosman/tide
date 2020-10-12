function _fake_tide_item_time
    set_color $fake_tide_time_color
    printf '%s' (date +$fake_tide_time_format)
end