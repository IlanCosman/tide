function _fake_tide_prompt
    left_prompt=(_fake_tide_left_prompt) right_prompt=(_fake_tide_right_prompt) if set -q left_prompt[2] # If prompt is two lines
        set -l prompt_and_frame_color (set_color $fake_tide_prompt_color_frame_and_connection -b normal || echo)

        if test "$fake_tide_left_prompt_frame_enabled" = true
            set left_prompt[1] $prompt_and_frame_color╭─"$left_prompt[1]"
            set left_prompt[2] $prompt_and_frame_color╰─"$left_prompt[2]"
        end
        if test "$fake_tide_right_prompt_frame_enabled" = true
            set right_prompt[1] "$right_prompt[1]"$prompt_and_frame_color─╮
            set right_prompt[2] "$right_prompt[2]"$prompt_and_frame_color─╯
        end

        printf '%s' $left_prompt[1] $prompt_and_frame_color

        set -l dist_btwn_sides (math $fake_columns - ( # Regex removes color codes
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[1]""$right_prompt[1]" | string length))
        test $dist_btwn_sides -gt 0 && string repeat --no-newline --max $dist_btwn_sides $fake_tide_prompt_icon_connection

        printf '%s' $right_prompt[1] \n $left_prompt[-1]' '

        string repeat --no-newline --max (math $fake_columns - ( # The -1 is necessary for some reason
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[-1]""$right_prompt[-1]" | string length) - 1) ' '
        printf '%s' $right_prompt[2]
    else
        printf '%s' $left_prompt[-1]' '

        string repeat --no-newline --max (math $fake_columns - ( # The -1 is necessary for some reason
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[-1]""$right_prompt[-1]" | string length) - 1) ' '
        printf '%s' $right_prompt[-1]
    end

    set_color normal
end

function _fake_tide_left_prompt
    set -g _fake_tide_last_item newline
    set -g _fake_tide_which_side_working_on left

    for item in $fake_tide_left_prompt_items
        _fake_tide_item_$item
    end

    if not contains -- $_fake_tide_last_item newline character
        set_color $_fake_tide_previous_bg_color -b normal
        printf '%s' $fake_tide_left_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _fake_tide_right_prompt
    set -g _fake_tide_last_item newline
    set -g _fake_tide_which_side_working_on right

    for item in $fake_tide_right_prompt_items
        _fake_tide_item_$item
    end

    if test "$_fake_tide_last_item" != newline
        set_color $_fake_tide_previous_bg_color -b normal
        printf '%s' $fake_tide_right_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end
