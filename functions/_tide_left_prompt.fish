function _tide_left_prompt
    set lastItemWasNewline # Display prefix instead of separator before first item
    set color normal

    for item in $tide_left_prompt_items
        if test "$item" = 'newline'
            _print_separator

            printf '%b' '\n'
            set lastItemWasNewline

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            set -l colorName 'tide_'$item'_bg_color'
            set -l color $$colorName

            set_color -b $color

            if set -q lastItemWasNewline
                printf '%s' $tide_left_prompt_prefix
                set -e lastItemWasNewline
            else
                _print_separator
            end

            printf '%b' $output
            set previousColor $color
        end
    end

    if not set -q lastItemWasNewline
        set color normal
        _print_separator
    end

    set_color normal # Prompt won't display a newline at the end without something printed on it
end

function _print_separator --no-scope-shadowing
    if test "$color" = "$previousColor"
        switch $tide_left_prompt_item_separator
            case ''
            case ' '
                printf '%s' ' '
            case '*'
                printf '%s' ' '$tide_left_prompt_item_separator' '
        end
    else
        switch $tide_left_prompt_item_separator_diff_color
            case ''
            case ' '
                printf '%s' ' '
            case '*'
                set_color -b $previousColor 2>/dev/null # Piping errors to null is necessary for newline at the start of prompt items
                printf '%s' ' '(set_color -b $color)(set_color $previousColor)$tide_left_prompt_item_separator_diff_color' '
        end
    end
end