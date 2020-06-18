function pure_prompt_height
    _title 'Prompt Height?'

    _option 1 'One line'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'prompt_char'
    _display_prompt

    _option 2 'Two lines'
    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/r/q)
        case 1
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'prompt_char'
            _next_choice 'all/prompt_spacing'
        case 2
            set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
            _next_choice 'all/prompt_spacing'
        case r
            _begin
        case q
            _quit
    end
end