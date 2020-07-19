function classic_prompt_separators
    _tide_title 'Prompt Separators'

    _tide_option 1 'Angled'
    set -g fake_tide_left_prompt_item_separator_same_color ''
    set -g fake_tide_right_prompt_item_separator_same_color ''
    _tide_display_prompt

    _tide_option 2 'Vertical'
    set -g fake_tide_left_prompt_item_separator_same_color '│'
    set -g fake_tide_right_prompt_item_separator_same_color '│'
    _tide_display_prompt

    _tide_option 3 'Slanted'
    set -g fake_tide_left_prompt_item_separator_same_color '╱'
    set -g fake_tide_right_prompt_item_separator_same_color '╱'
    _tide_display_prompt

    _tide_option 4 'Round'
    set -g fake_tide_left_prompt_item_separator_same_color ''
    set -g fake_tide_right_prompt_item_separator_same_color ''
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_left_prompt_item_separator_same_color ''
            set -g fake_tide_right_prompt_item_separator_same_color ''
            _next_choice 'classic/classic_prompt_heads'
        case 2
            set -g fake_tide_left_prompt_item_separator_same_color '│'
            set -g fake_tide_right_prompt_item_separator_same_color '│'
            _next_choice 'classic/classic_prompt_heads'
        case 3
            set -g fake_tide_left_prompt_item_separator_same_color '╱'
            set -g fake_tide_right_prompt_item_separator_same_color '╱'
            _next_choice 'classic/classic_prompt_heads'
        case 4
            set -g fake_tide_left_prompt_item_separator_same_color ''
            set -g fake_tide_right_prompt_item_separator_same_color ''
            _next_choice 'classic/classic_prompt_heads'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end