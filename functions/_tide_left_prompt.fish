function _tide_left_prompt
    set lastItemWasNewline

    for item in $tide_left_prompt_items
        if test "$item" = newline
            set_color $previousColor -b normal
            printf '%s' $tide_left_prompt_suffix\n
            set lastItemWasNewline
        else
            set -l output (_tide_item_$item)
            if test -n "$output"
                set -l colorName tide_"$item"_bg_color
                set -l color $$colorName

                if set -e lastItemWasNewline
                    if test "$item" != prompt_char
                        set_color $color -b normal
                        printf '%s' $tide_left_prompt_prefix
                    end
                else if test "$color" = "$previousColor"
                    set_color $tide_left_prompt_item_separator_same_color_color
                    printf '%s' $tide_left_prompt_item_separator_same_color
                else
                    set_color $previousColor -b $color
                    printf '%s' $tide_left_prompt_item_separator_diff_color
                end

                set_color -b $color

                if test "$tide_left_prompt_pad_items" = true -a "$item" != prompt_char
                    printf '%s' " $output "
                else
                    printf '%s' "$output"
                end

                set previousColor $color

                test "$item" = prompt_char && set lastItemWasPromptChar
            end
        end
    end

    if not set -q lastItemWasNewline && not set -q lastItemWasPromptChar
        set_color $previousColor -b normal
        printf '%s' $tide_left_prompt_suffix
    end

    set_color normal
end
