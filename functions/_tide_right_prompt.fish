function _tide_right_prompt
    set -l splitText (_fetch_right_prompt_items | string split '\n')
    set -l printAtEndedRightPromptHeight (count $splitText)

    if test "$tide_right_prompt_frame_enabled" = 'true'
        # The right frame should always look exactly like the left frame would, regardless of how many lines splitText actually has.
        # In this section we check if each line exist, if so add the frame to it. If not, insert a line containing only the frame
        # and update printAtEndedRightPromptHeight

        set -l frameColor (set_color $tide_right_prompt_frame_color)

        if test $_tide_left_prompt_height -gt 1
            set splitText[1] $splitText[1]$frameColor'─╮'

            if test $printAtEndedRightPromptHeight -gt 1
                set splitText[-1] $splitText[-1]$frameColor'─╯'
            else
                set splitText[2] $frameColor'─╯'
                set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight+1)
            end

            if test $_tide_left_prompt_height -gt 2
                if test $printAtEndedRightPromptHeight -gt 2
                    set splitText[2..-2] $splitText[2..-2]'─┤'
                else
                    set splitText $splitText[1] '─┤' $splitText[2]
                    set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight+1)
                end
            end
        end
    end

    for lineOfText in $splitText[1..-2]
        _print_at_end $lineOfText
    end

    if test $printAtEndedRightPromptHeight -eq $_tide_left_prompt_height
        set -g _tide_right_prompt_fish $splitText[-1]
        set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight-1)
    else
        _print_at_end $splitText[-1]
        set -g _tide_right_prompt_fish ''
    end

    _cursor_up $printAtEndedRightPromptHeight
end

function fish_right_prompt
    printf '%s' $_tide_right_prompt_fish
end

function _print_at_end -a text
    set -l startLocation (math $COLUMNS -(_tide_decolor $text | string length))
    _cursor_right $startLocation

    printf '%s%b' $text '\v\r'
end

function _fetch_right_prompt_items
    set previousColor normal

    for item in $tide_right_prompt_items
        if test "$item" = 'newline'
            printf '%s' $tide_right_prompt_suffix'\n'
            set previousColor normal

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            set -l colorName 'tide_'$item'_bg_color'
            set -l color $$colorName


            if set -e dontDisplayNextSeparator
            else
                _print_right_prompt_separator
            end

            set_color -b $color
            printf '%b' $output

            set previousColor $color

            if test "$item" = 'prompt_char'
                set dontDisplayNextSeparator
            end
        end
    end

    printf '%s' "$tide_right_prompt_suffix"

    set_color normal # Prompt won't display a newline at the end without something printed on it
end

function _print_right_prompt_separator --no-scope-shadowing
    if test "$color" = "$previousColor"
        set_color $tide_right_prompt_item_separator_same_color_color

        if test "$tide_right_prompt_pad_separators" = 'true'
            printf '%s' ' '$tide_right_prompt_item_separator_same_color' '
        else
            printf '%s' $tide_right_prompt_item_separator_same_color
        end
    else
        set_color -b $previousColor 2>/dev/null #Neccesary for first item newline

        if test "$tide_right_prompt_pad_separators" = 'true'
            printf '%s' ' '(set_color -b $previousColor $color)$tide_right_prompt_item_separator_diff_color(set_color -b $color)' '
        else
            printf '%s' (set_color -b $previousColor $color)$tide_right_prompt_item_separator_diff_color
        end
    end
end