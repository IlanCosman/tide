function icons
    _tide_title Icons

    _tide_option 1 'Few icons'
    _tide_display_prompt

    _tide_option 2 'Many icons'
    _enable_icons
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            _disable_icons
    end
    _next_choice all/finish
end

function _enable_icons
    set -p fake_tide_left_prompt_items os
    set -g fake_tide_pwd_icon 
    set -g fake_tide_pwd_icon_home 
    set -g fake_tide_cmd_duration_icon 
    set -g fake_tide_git_icon 
end

function _disable_icons
    _tide_find_and_remove os fake_tide_left_prompt_items
    set fake_tide_pwd_icon
    set fake_tide_pwd_icon_home
    set fake_tide_cmd_duration_icon
    set fake_tide_git_icon
end
