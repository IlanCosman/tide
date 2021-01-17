function _fake_tide_right_prompt
    set -l splitText (_fake_tide_fetch_right_prompt_items)
    set -l rightPromptHeight (count $splitText)
    set -l leftPromptHeight (math 1+(string match --all 'newline' $fake_tide_left_prompt_items | count))

    if test "$fake_tide_right_prompt_frame_enabled" = 'true'
        set -l frameColor (set_color $fake_tide_right_prompt_frame_color -b normal || echo)

        set splitText[1] $splitText[1]$frameColor'─╮'

        test $leftPromptHeight -gt 1 && if test $rightPromptHeight -gt 1
            set splitText[-1] $splitText[-1]$frameColor'─╯'
        else
            set splitText[2] $frameColor'─╯'
            set rightPromptHeight (math $rightPromptHeight+1)
        end
    end

    for lineOfText in $splitText
        _fake_tide_print_at_end $lineOfText
    end

    _tide_cursor_up $rightPromptHeight
end

function _fake_tide_fetch_right_prompt_items
    set lastItemWasNewline

    set_color normal

    for item in $fake_tide_right_prompt_items
        if test "$item" = 'newline'
            set_color $previousColor -b normal
            printf '%s' $fake_tide_right_prompt_suffix\n
            set lastItemWasNewline
        else
            set -l output (_fake_tide_item_$item)
            if test -n "$output"
                set -l colorName fake_tide_"$item"_bg_color
                set -l color $$colorName
                test -n "$color" || set color normal

                if set -e lastItemWasNewline
                    set_color $color -b normal
                    printf '%s' $fake_tide_right_prompt_prefix
                else
                    if test "$color" = "$previousColor"
                        set_color $fake_tide_right_prompt_item_separator_same_color_color
                        printf '%s' $fake_tide_right_prompt_item_separator_same_color
                    else
                        set_color $color -b $previousColor
                        printf '%s' $fake_tide_right_prompt_item_separator_diff_color
                    end
                end

                set_color -b $color

                if test "$fake_tide_right_prompt_pad_items" = 'true'
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
        printf '%s' $fake_tide_right_prompt_suffix
    end
end

function _fake_tide_print_at_end -a text
    set -l startLocation (math $fake_columns -(_tide_decolor $text | string length))
    _tide_cursor_right $startLocation

    printf '%s%b' $text '\v\r' # For some reason \n doesn't work but \v\r does
end