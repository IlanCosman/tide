function ascii_friendly
    set -e _tide_ascii_friendly # Clear on restart

    _tide_title 'ASCII-Friendly Prompt'

    echo
    echo 'Choose Yes if your terminal does not support Nerd Fonts or powerline glyphs.'
    echo

    _tide_option 1 No
    _tide_option 2 Yes

    _tide_menu (status function) --no-restart
    switch $_tide_selected_option
        case Yes
            set -g _tide_ascii_friendly true
    end
    _next_choice all/style
end

function _tide_apply_ascii_overrides
    # Replace powerline glyphs with ASCII equivalents
    set -g fake_tide_left_prompt_separator_diff_color '>'
    set -g fake_tide_right_prompt_separator_diff_color '<'
    set -g fake_tide_left_prompt_separator_same_color '|'
    set -g fake_tide_right_prompt_separator_same_color '|'
    set -g fake_tide_left_prompt_suffix '>'
    set -g fake_tide_right_prompt_prefix '<'
    set -g fake_tide_left_prompt_prefix '['
    set -g fake_tide_right_prompt_suffix ']'
    set -g fake_tide_prompt_icon_connection -
    _disable_icons
end
