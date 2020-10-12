function prompt_spacing
    _tide_title 'Prompt Spacing'

    _tide_option 1 'Compact'
    _tide_display_prompt
    _tide_cursor_up 1
    _tide_display_prompt

    _tide_option 2 'Sparse'
    _tide_display_prompt
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_print_newline_before_prompt false
            _next_choice 'all/finish'
        case 2
            set -g fake_tide_print_newline_before_prompt true
            _next_choice 'all/finish'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end