function rainbow_prompt_separators
    _tide_title 'Prompt Separators'

    _tide_option 1 Angled
    set -g fake_tide_left_prompt_separator_diff_color 
    set -g fake_tide_right_prompt_separator_diff_color 
    _tide_display_prompt

    _tide_option 2 Vertical
    set -g fake_tide_left_prompt_separator_diff_color ''
    set -g fake_tide_right_prompt_separator_diff_color ''
    _tide_display_prompt

    _tide_option 3 Slanted
    set -g fake_tide_left_prompt_separator_diff_color ''
    set -g fake_tide_right_prompt_separator_diff_color ''
    _tide_display_prompt

    _tide_option 4 Round
    set -g fake_tide_left_prompt_separator_diff_color ''
    set -g fake_tide_right_prompt_separator_diff_color ''
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case Angled
            set -g fake_tide_left_prompt_separator_diff_color 
            set -g fake_tide_right_prompt_separator_diff_color 
        case Vertical
            set -g fake_tide_left_prompt_separator_diff_color ''
            set -g fake_tide_right_prompt_separator_diff_color ''
        case Slanted
            set -g fake_tide_left_prompt_separator_diff_color ''
            set -g fake_tide_right_prompt_separator_diff_color ''
        case Round
            set -g fake_tide_left_prompt_separator_diff_color ''
            set -g fake_tide_right_prompt_separator_diff_color ''
    end
    _next_choice powerline/powerline_prompt_heads
end
