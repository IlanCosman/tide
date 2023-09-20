function transient
    _tide_title 'Enable transient prompt?'

    _tide_option 1 No
    _tide_display_prompt
    _tide_display_prompt
    _tide_display_prompt

    _tide_option 2 Yes
    _configure_transient= _tide_display_prompt
    _configure_transient= _tide_display_prompt
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case No
            set fake_tide_prompt_transient_enabled false
        case Yes
            set fake_tide_prompt_transient_enabled true
    end
    _next_choice all/finish
end
