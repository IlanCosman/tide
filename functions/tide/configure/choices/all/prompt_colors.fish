function prompt_colors
    _tide_title 'Prompt Colors'

    _tide_option 1 'True color'
    _tide_display_prompt

    _tide_option 2 '16 colors'
    _load_config "$_tide_configure_style"_16color
    set -g _tide_16color true
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            _load_config "$_tide_configure_style"
            set -e _tide_16color
            switch $_tide_configure_style
                case lean rainbow
                    _next_choice 'all/show_time'
                case classic
                    _next_choice 'classic/classic_prompt_color'
            end
        case 2
            _next_choice 'all/show_time'
    end
end