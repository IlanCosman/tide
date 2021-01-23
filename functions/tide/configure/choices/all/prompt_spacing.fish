function prompt_spacing
    _tide_title 'Prompt Spacing'

    _tide_option 1 'Compact'
    _tide_display_prompt
    _tide_cursor_up 1
    _tide_display_prompt

    _tide_option 2 'Sparse'
    _tide_display_prompt
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_print_newline_before_prompt false
        case 2
            set -g fake_tide_print_newline_before_prompt true
    end
    _next_choice 'all/icons'
end