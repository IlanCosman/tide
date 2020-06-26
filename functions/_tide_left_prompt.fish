function _tide_left_prompt
    set lastItemWasNewline # Display prefix instead of separator before first item
    set color normal

    for item in $tide_left_prompt_items
        if test "$item" = 'newline'
            if not set -q lastItemWasNewline && not set -q dontDisplayNextSeparator
                set color normal
                _print_left_prompt_separator
            end

            printf '%b' '\n'
            set lastItemWasNewline

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            set -l colorName 'tide_'$item'_bg_color'
            set -l color $$colorName

            if set -q lastItemWasNewline
                if test "$item" != 'prompt_char'
                    printf '%s' $tide_left_prompt_prefix
                end
                set -e lastItemWasNewline
            else if set -q dontDisplayNextSeparator
                set -e dontDisplayNextSeparator
            else
                _print_left_prompt_separator
            end
            
            set_color -b $color
            printf '%b' $output
           
            set previousColor $color

            if test "$item" = 'prompt_char'
                set dontDisplayNextSeparator
            end
        end
    end

    if not set -q lastItemWasNewline && not set -q dontDisplayNextSeparator
        set color normal
        _print_left_prompt_separator
    end

    set_color normal # Prompt won't display a newline at the end without something printed on it
end

function _print_left_prompt_separator --no-scope-shadowing
    if test "$color" = "$previousColor"
        if test "$tide_left_prompt_pad_separators" = 'true'
            printf '%s' ' '$tide_left_prompt_item_separator' '
        else
            printf '%s' $tide_left_prompt_item_separator
        end
    else
        set_color -b $previousColor 2>/dev/null #Neccesary for first item newline

        if test "$tide_left_prompt_pad_separators" = 'true'
            printf '%s' ' '(set_color -b $color $previousColor)$tide_left_prompt_item_separator_diff_color' '
        else
            printf '%s' (set_color -b $color $previousColor)$tide_left_prompt_item_separator_diff_color
        end
    end
end