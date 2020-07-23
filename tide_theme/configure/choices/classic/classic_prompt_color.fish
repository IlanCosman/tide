function classic_prompt_color
    _tide_title 'Prompt Color'

    _tide_option 1 'Lightest'
    _set_all_items_bg_color 585858
    _tide_display_prompt

    _tide_option 2 'Light'
    _set_all_items_bg_color 444444
    _tide_display_prompt

    _tide_option 3 'Dark'
    _set_all_items_bg_color 303030
    _tide_display_prompt

    _tide_option 4 'Darkest'
    _set_all_items_bg_color 1C1C1C
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            _set_all_items_bg_color 585858
            _next_choice 'classic/classic_show_time'
        case 2
            _set_all_items_bg_color 444444
            _next_choice 'classic/classic_show_time'
        case 3
            _set_all_items_bg_color 303030
            _next_choice 'classic/classic_show_time'
        case 4
            _set_all_items_bg_color 1C1C1C
            _next_choice 'classic/classic_show_time'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end

function _set_all_items_bg_color -a color
    for var in (set --names | string match --regex "fake_.*_bg_color")
        set $var $color
    end
end