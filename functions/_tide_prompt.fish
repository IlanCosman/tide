function _tide_prompt
    # Variables are exported as strings, convert _tide_last_pipestatus back into a list
    set -g _tide_last_pipestatus (string split ' ' $_tide_last_pipestatus)

    test "$tide_prompt_add_newline_before" = true && echo

    set -l leftPrompt (_tide_left_prompt)
    set -l rightPrompt (_tide_right_prompt)

    if set -q leftPrompt[2] # If the prompt is two lines
        set -l promptAndFrameColor (set_color $tide_prompt_frame_and_connection_color -b normal || echo)

        if test "$tide_left_prompt_frame_enabled" = true
            set leftPrompt[1] $promptAndFrameColor╭─"$leftPrompt[1]"
            set leftPrompt[2] $promptAndFrameColor╰─"$leftPrompt[2]"
        end
        if test "$tide_right_prompt_frame_enabled" = true
            set rightPrompt[1] "$rightPrompt[1]"$promptAndFrameColor─╮
            set rightPrompt[2] "$rightPrompt[2]"$promptAndFrameColor─╯
        end

        printf '%s' $leftPrompt[1] $promptAndFrameColor

        set -l lengthToMove (math $COLUMNS - (_tide_decolor "$leftPrompt[1]""$rightPrompt[1]" | string length))
        test $lengthToMove -gt 0 && string repeat --no-newline --max $lengthToMove $tide_prompt_connection_icon

        printf '%s' $rightPrompt[1] \n $leftPrompt[-1]' '
        set -U $_tide_right_prompt_display_var $rightPrompt[2]
    else
        printf '%s' $leftPrompt[-1]' '
        set -U $_tide_right_prompt_display_var $rightPrompt[1]
    end
end

function _tide_left_prompt
    set -g tide_last_item newline
    set -g _tide_which_side_working_on left

    for item in $tide_left_prompt_items
        _tide_item_$item
    end

    if not contains -- $tide_last_item newline character
        set_color $tide_previous_bg_color -b normal
        printf '%s' $tide_left_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _tide_right_prompt
    set -g tide_last_item newline
    set -g _tide_which_side_working_on right

    for item in $tide_right_prompt_items
        _tide_item_$item
    end

    if test "$tide_last_item" != newline
        set_color $tide_previous_bg_color -b normal
        printf '%s' $tide_right_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end
