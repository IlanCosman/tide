function rainbow_prompt_separators
    _title 'Prompt Separators'

    _option 1 'Angled'
    set -g fake_tide_left_prompt_item_separator_diff_color ''
    set -g fake_tide_right_prompt_item_separator_diff_color ''
    _display_prompt

    _option 2 'Vertical'
    set -g fake_tide_left_prompt_item_separator_diff_color ''
    set -g fake_tide_right_prompt_item_separator_diff_color ''
    _display_prompt

    _option 3 'Slanted'
    set -g fake_tide_left_prompt_item_separator_diff_color ''
    set -g fake_tide_right_prompt_item_separator_diff_color ''
    _display_prompt

    _option 4 'Round'
    set -g fake_tide_left_prompt_item_separator_diff_color ''
    set -g fake_tide_right_prompt_item_separator_diff_color ''
    _display_prompt

    _display_restart_and_quit

    switch (_menu)
        case 1
            set -g fake_tide_left_prompt_item_separator_diff_color ''
            set -g fake_tide_right_prompt_item_separator_diff_color ''
            _next_choice 'rainbow/rainbow_prompt_heads'
        case 2
            set -g fake_tide_left_prompt_item_separator_diff_color ''
            set -g fake_tide_right_prompt_item_separator_diff_color ''
            _next_choice 'rainbow/rainbow_prompt_heads'
        case 3
            set -g fake_tide_left_prompt_item_separator_diff_color ''
            set -g fake_tide_right_prompt_item_separator_diff_color ''
            _next_choice 'rainbow/rainbow_prompt_heads'
        case 4
            set -g fake_tide_left_prompt_item_separator_diff_color ''
            set -g fake_tide_right_prompt_item_separator_diff_color ''
            _next_choice 'rainbow/rainbow_prompt_heads'
        case r
            _begin
        case q
            _quit
    end
end