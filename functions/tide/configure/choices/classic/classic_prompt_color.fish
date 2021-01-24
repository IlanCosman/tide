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

    _tide_menu
    switch $_tide_selected_option
        case 1
            _set_all_items_bg_color 585858
        case 2
            _set_all_items_bg_color 444444
        case 3
            _set_all_items_bg_color 303030
        case 4
            _set_all_items_bg_color 1C1C1C
    end
    _next_choice 'all/show_time'
end