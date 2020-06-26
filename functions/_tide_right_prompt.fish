function _tide_right_prompt
    set -l splitText (_fetch_right_prompt_items | string split '\n')
    set -l printAtEndedRightPromptHeight (count $splitText)

    for thing in $splitText[1..-2]
        _print_at_end $thing
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
            if not set -q lastItemWasNewline && not set -q dontDisplayNextSeparator
                set color normal
                _print_right_prompt_separator
            end

            printf '%s' $tide_right_prompt_suffix'\n'
            set lastItemWasNewline

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            set -l colorName 'tide_'$item'_bg_color'
            set -l color $$colorName


            if set -e lastItemWasNewline
            else if set -e dontDisplayNextSeparator
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
        if test "$tide_right_prompt_pad_separators" = 'true'
            printf '%s' ' '$tide_right_prompt_item_separator' '
        else
            printf '%s' $tide_right_prompt_item_separator
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