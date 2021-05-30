function _tide_prompt
    # Variables are exported as strings, convert _tide_last_pipestatus back into a list
    set -g _tide_last_pipestatus (string split ' ' $_tide_last_pipestatus)

    test "$tide_prompt_add_newline_before" = true && echo

    left_prompt=(_tide_left_prompt) right_prompt=(_tide_right_prompt) if set -q left_prompt[2] # If prompt is two lines
        set -lx dist_btwn_sides (math $COLUMNS + 7 - ( # Regex removes color. 7 = @@PWD@@ length which will be replaced
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[1]""$right_prompt[1]" | string length))
        set left_prompt[1] (string replace @@PWD@@ (_tide_pwd) "$left_prompt[1]")
        set dist_btwn_sides (math $dist_btwn_sides - $pwd_length)

        set -l prompt_and_frame_color (set_color $tide_prompt_color_frame_and_connection -b normal || echo)
        if test "$tide_left_prompt_frame_enabled" = true
            set left_prompt[1] $prompt_and_frame_color╭─"$left_prompt[1]"
            set left_prompt[2] $prompt_and_frame_color╰─"$left_prompt[2]"
        end
        if test "$tide_right_prompt_frame_enabled" = true
            set right_prompt[1] "$right_prompt[1]"$prompt_and_frame_color─╮
            set right_prompt[2] "$right_prompt[2]"$prompt_and_frame_color─╯
        end

        printf '%s' $left_prompt[1] $prompt_and_frame_color
        test $dist_btwn_sides -gt 0 && string repeat --no-newline --max $dist_btwn_sides $tide_prompt_icon_connection
        printf '%s' $right_prompt[1] \n $left_prompt[2]' '
        set -U $_tide_right_prompt_display_var $right_prompt[2]
    else
        set -lx dist_btwn_sides (math $COLUMNS - 19 - ( # 19 = 26 - 7. We want min 26 cols for user
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[1]""$right_prompt[1]" | string length))
        set left_prompt[1] (string replace @@PWD@@ (_tide_pwd) "$left_prompt[1]")
        set dist_btwn_sides (math $dist_btwn_sides - $pwd_length)

        printf '%s' $left_prompt[1]' '
        set -U $_tide_right_prompt_display_var $right_prompt[1]
    end
end

function _tide_left_prompt
    set -g _tide_last_item newline
    set -g _tide_which_side_working_on left

    for item in $tide_left_prompt_items
        _tide_item_$item
    end

    if not contains -- $_tide_last_item newline character
        set_color $_tide_previous_bg_color -b normal
        printf '%s' $tide_left_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _tide_right_prompt
    set -g _tide_last_item newline
    set -g _tide_which_side_working_on right

    for item in $tide_right_prompt_items
        _tide_item_$item
    end

    if test "$_tide_last_item" != newline
        set_color $_tide_previous_bg_color -b normal
        printf '%s' $tide_right_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _tide_item_pwd
    _tide_print_item pwd @@PWD@@
end
