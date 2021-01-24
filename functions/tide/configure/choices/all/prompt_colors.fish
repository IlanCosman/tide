function prompt_colors
    _tide_title 'Prompt Colors'

    _tide_option 1 'True color'
    _tide_display_prompt

    _tide_option 2 '16 colors'
    set -g fake_tide_true_color 0
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_true_color 1
    end
    switch $_tide_configure_style
        case lean rainbow
            _next_choice 'all/show_time'
        case classic
            _next_choice 'classic/classic_prompt_color'
    end
end