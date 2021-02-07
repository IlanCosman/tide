function _tide_right_prompt
    set -l splitText (_tide_fetch_right_prompt_items)
    set -l rightPromptHeight (count $splitText)
    set -l leftPromptHeight (math 1+(string match --all 'newline' $tide_left_prompt_items | count))

    if test "$tide_right_prompt_frame_enabled" = 'true'
        set -l frameColor (set_color $tide_right_prompt_frame_color -b normal || echo)

        set splitText[1] $splitText[1]$frameColor'─╮'

        test $leftPromptHeight -gt 1 && if test $rightPromptHeight -gt 1
            set splitText[-1] $splitText[-1]$frameColor'─╯'
        else
            set splitText[2] $frameColor'─╯'
            set rightPromptHeight (math $rightPromptHeight+1)
        end
    end

    for lineOfText in $splitText[1..-2]
        _tide_print_at_end $lineOfText
    end

    if test $rightPromptHeight -eq $leftPromptHeight
        set -U _tide_right_prompt_display_$_tide_fish_pid $splitText[-1]
        set rightPromptHeight (math $rightPromptHeight-1)
    else
        set -U _tide_right_prompt_display_$_tide_fish_pid
        _tide_print_at_end $splitText[-1]
    end

    _tide_cursor_up $rightPromptHeight
end

function _tide_fetch_right_prompt_items
    set lastItemWasNewline

    set_color normal

    for item in $tide_right_prompt_items
        if test "$item" = 'newline'
            set_color $previousColor -b normal
            printf '%s' $tide_right_prompt_suffix\n
            set lastItemWasNewline
        else
            set -l output (_tide_item_$item)
            if test -n "$output"
                set -l colorName tide_"$item"_bg_color
                set -l color $$colorName

                if set -e lastItemWasNewline
                    set_color $color -b normal
                    printf '%s' $tide_right_prompt_prefix
                else if test "$color" = "$previousColor"
                    set_color $tide_right_prompt_item_separator_same_color_color
                    printf '%s' $tide_right_prompt_item_separator_same_color
                else
                    set_color $color -b $previousColor
                    printf '%s' $tide_right_prompt_item_separator_diff_color
                end

                set_color -b $color

                if test "$tide_right_prompt_pad_items" = 'true'
                    printf '%s' " $output "
                else
                    printf '%s' "$output"
                end

                set previousColor $color
            end
        end
    end

    if not set -q lastItemWasNewline
        set_color $previousColor -b normal
        printf '%s' $tide_right_prompt_suffix
    end
end

function _tide_print_at_end -a text
    set -l startLocation (math $COLUMNS -(_tide_decolor $text | string length))
    _tide_cursor_right $startLocation

    printf '%s%b' $text '\v\r' # For some reason \n doesn't work but \v\r does
end