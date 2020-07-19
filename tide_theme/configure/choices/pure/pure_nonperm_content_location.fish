function pure_nonperm_content_location
    _tide_title 'Non-permanent content location'

    _tide_option 1 'Left'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
    _tide_display_prompt

    _tide_option 2 'Right'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    set -g fake_tide_right_prompt_items 'cmd_duration'
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
            set -g fake_tide_right_prompt_items
            _next_choice 'pure/pure_show_time'
        case 2
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
            set -g fake_tide_right_prompt_items 'cmd_duration'
            _next_choice 'pure/pure_show_time'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end