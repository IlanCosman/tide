function classic_prompt_color
    _title 'Prompt Color'

    _option 1 'Lightest'
    _set_all_items_bg_color 585858
    _display_prompt

    _option 2 'Light'
    _set_all_items_bg_color 444444
    _display_prompt

    _option 3 'Dark'
    _set_all_items_bg_color 303030
    _display_prompt

    _option 4 'Darkest'
    _set_all_items_bg_color 1C1C1C
    _display_prompt

    _display_restart_and_quit

    switch (_menu)
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
            _begin
        case q
            _quit
    end
end

function _set_all_items_bg_color -a color
    set fake_tide_cmd_duration_bg_color $color
    set fake_tide_context_bg_color $color
    set fake_tide_git_prompt_bg_color $color
    set fake_tide_jobs_bg_color $color
    set fake_tide_pwd_bg_color $color
    set fake_tide_status_success_bg_color $color
    set fake_tide_status_failure_bg_color $color
    set fake_tide_time_bg_color $color
    set fake_tide_virtual_env_bg_color $color
end