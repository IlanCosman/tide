function pure_prompt_height
    _title 'Prompt Height?'

    # This is a quickfix for me being a noob
    if contains 'cmd_duration' $fake_tide_left_prompt_items
        set hasCmdDuration true
    else
        set -e hasCmdDuration
    end

    _option 1 'One line'
    if set -q hasCmdDuration
        set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'prompt_char'
    else
        set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'prompt_char'
    end
    _display_prompt

    _option 2 'Two lines'
    if set -q hasCmdDuration
        set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
    else
        set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    end
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/r/q)
        case 1
            if set -q hasCmdDuration
                set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'prompt_char'
            else
                set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'prompt_char'
            end
            _next_choice 'all/prompt_spacing'
        case 2
            if set -q hasCmdDuration
                set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'cmd_duration' 'newline' 'prompt_char'
            else
                set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
            end
            _next_choice 'all/prompt_spacing'
        case r
            _begin
        case q
            _quit
    end
end