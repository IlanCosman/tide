function pure_nonperm_content_location
    _title 'Non-permanent content location'

    _option 1 'Left'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
    _display_prompt

    _option 2 'Right'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    set -g fake_tide_right_prompt_items 'cmd_duration'
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/r/q)
        case 1
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
            set -g fake_tide_right_prompt_items
            _next_choice 'pure/pure_show_time'
        case 2
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
            set -g fake_tide_right_prompt_items 'cmd_duration'
            _next_choice 'pure/pure_show_time'
        case r
            _begin
        case q
            _quit
    end
end