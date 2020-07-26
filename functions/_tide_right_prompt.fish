function _tide_right_prompt
    set -l splitText (_tide_fetch_right_prompt_items | string split '@NEWLINE@')
    set -l printAtEndedRightPromptHeight (count $splitText)

    if test "$tide_right_prompt_frame_enabled" = 'true'
        # The right frame should always look exactly like the left frame would, regardless of how many lines splitText actually has.
        # In this section we check if each line exist, if so add the frame to it. If not, insert a line containing only the frame
        # and update printAtEndedRightPromptHeight

        set -l frameColor (set_color $tide_right_prompt_frame_color -b normal)

        set splitText[1] $splitText[1]$frameColor'─╮'

        if test $_tide_left_prompt_height -gt 1
            if test $printAtEndedRightPromptHeight -gt 1
                set splitText[-1] $splitText[-1]$frameColor'─╯'
            else
                set splitText[2] $frameColor'─╯'
                set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight+1)
            end

            if test $_tide_left_prompt_height -gt 2
                if test $printAtEndedRightPromptHeight -gt 2
                    set splitText[2..-2] $splitText[2..-2]$frameColor'─┤'
                else
                    set splitText $splitText[1] $frameColor'─┤' $splitText[2]
                    set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight+1)
                end
            end
        end
    end

    for lineOfText in $splitText[1..-2]
        _tide_print_at_end $lineOfText
    end

    if test $printAtEndedRightPromptHeight -eq $_tide_left_prompt_height
        set -g _tide_fish_right_prompt_display $splitText[-1]
        set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight-1)
    else
        _tide_print_at_end $splitText[-1]
        set -g _tide_fish_right_prompt_display ' '
    end

    _tide_cursor_up $printAtEndedRightPromptHeight
end

function _tide_fetch_right_prompt_items
    set lastItemWasNewline # Display prefix instead of separator before first item
    set color normal

    set_color normal

    for item in $tide_right_prompt_items
        if test "$item" = 'newline'
            if not set -q lastItemWasNewline
                set_color $previousColor -b normal
                printf '%s' $tide_right_prompt_suffix
            end

            printf '%b' '\n'

            set lastItemWasNewline

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            set -l colorName tide_"$item"_bg_color
            set -l color $$colorName
            if test -z "$color"
                set color normal
            end

            if set -e lastItemWasNewline
                set_color $color -b normal
                printf '%s' $tide_right_prompt_prefix
            else
                if test "$color" = "$previousColor"
                    set_color $tide_right_prompt_item_separator_same_color_color
                    printf '%s' $tide_right_prompt_item_separator_same_color
                else
                    set_color $color -b $previousColor
                    printf '%s' $tide_right_prompt_item_separator_diff_color
                end
            end

            set_color -b $color

            if test "$tide_right_prompt_pad_items" = 'true'
                printf '%s' ' '$output(set_color -b $color)' ' # The set_color is for git_prompt which resets the background color
            else
                printf '%s' "$output"
            end

            set previousColor $color
        end
    end

    if not set -q lastItemWasNewline
        set_color $previousColor -b normal
        printf '%s' $tide_right_prompt_suffix
    end
end

function fish_right_prompt
    printf '%s' $_tide_fish_right_prompt_display
end

function _tide_print_at_end -a text
    set -l startLocation (math $COLUMNS -(_tide_decolor $text | string length))
    _tide_cursor_right $startLocation

    printf '%s%b' $text '\v\r' # For some reason \n doesn't work but \v\r does
end