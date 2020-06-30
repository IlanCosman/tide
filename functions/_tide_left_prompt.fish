function _tide_left_prompt
    set lastItemWasNewline # Display prefix instead of separator before first item
    set color normal
    set currentHeight 1

    for item in $tide_left_prompt_items
        if test "$item" = 'newline'
            _print_frame

            if not set -q lastItemWasNewline && not set -q dontDisplayNextSeparator
                set color normal
                _print_left_prompt_separator
            end

            printf '%b' '\n'

            set lastItemWasNewline
            set currentHeight (math $currentHeight +1)

            continue
        end

        set -l output (_tide_item_$item)

        if test -n "$output"
            _print_frame

            set -l colorName tide_"$item"_bg_color
            set -l color $$colorName

            set_color -b $color

            if set -e lastItemWasNewline
                if test "$item" != 'prompt_char'
                    printf '%s' $tide_left_prompt_prefix
                end
            else if set -e dontDisplayNextSeparator
            else
                _print_left_prompt_separator
            end

            printf '%s' "$output"

            set previousColor $color

            if test "$item" = 'prompt_char'
                set dontDisplayNextSeparator
            end
        end
    end

    if set -q lastItemWasNewline
        if test "$tide_left_prompt_frame_enabled" = 'true'
            set_color $tide_left_prompt_frame_color
            printf '%s' '╰─'
        end

        set_color normal # Prompt won't display a newline at the end without something printed on it
    else if not set -q lastItemWasNewline && not set -q dontDisplayNextSeparator
        set color normal
        _print_left_prompt_separator
    end
end

function _print_left_prompt_separator --no-scope-shadowing
    if test "$color" = "$previousColor"
        if test "$tide_left_prompt_pad_separators" = 'true'
            printf '%s' ' '$tide_left_prompt_item_separator_same_color' '
        else
            printf '%s' $tide_left_prompt_item_separator_same_color
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

function _print_frame --no-scope-shadowing
    if set -q lastItemWasNewline && test "$tide_left_prompt_frame_enabled" = 'true'
        set_color $tide_left_prompt_frame_color

        if test $currentHeight -eq 1
            printf '%s' '╭─'
        else if test $currentHeight -lt $_tide_left_prompt_height
            printf '%s' '├─'
        else
            printf '%s' '╰─'
        end
    end
end