function pure_nonperm_content_location
    _tide_title 'Non-permanent content location'

    _tide_option 1 'Left'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'virtual_env' 'prompt_char'
    set -g fake_tide_right_prompt_items
    _tide_display_prompt

    _tide_option 2 'Right'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    set -g fake_tide_right_prompt_items 'cmd_duration' 'virtual_env'
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'virtual_env' 'prompt_char'
            set -g fake_tide_right_prompt_items
            _next_choice 'all/show_time'
        case 2
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
            set -g fake_tide_right_prompt_items 'cmd_duration' 'virtual_env'
            _next_choice 'all/show_time'
    end
end