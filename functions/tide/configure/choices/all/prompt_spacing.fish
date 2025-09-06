function prompt_spacing
    _tide_title 'Prompt Spacing'

    _tide_option 1 Compact
    set -g fake_tide_prompt_add_newline_before false
    set -g fake_tide_prompt_add_newline_after_pwd false
    _tide_display_prompt
    _tide_display_prompt

    _tide_option 2 Sparse
    set -g fake_tide_prompt_add_newline_before true
    set -g fake_tide_prompt_add_newline_after_pwd false
    _tide_display_prompt
    _tide_display_prompt

    _tide_option 3 'Extra Sparse'
    set -g fake_tide_prompt_add_newline_before true
    set -g fake_tide_prompt_add_newline_after_pwd true
    _tide_display_prompt
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case Compact
            set -g fake_tide_prompt_add_newline_before false
            set -g fake_tide_prompt_add_newline_after_pwd false
        case Sparse
            set -g fake_tide_prompt_add_newline_before true
            set -g fake_tide_prompt_add_newline_after_pwd false
        case 'Extra Sparse'
            set -g fake_tide_prompt_add_newline_before true
            set -g fake_tide_prompt_add_newline_after_pwd true
    end
    _next_choice all/icons
end
