function _tide_right_prompt
    set lastItemWasNewline

    for item in $tide_right_prompt_items
        if test "$item" = newline
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

                if test "$tide_right_prompt_pad_items" = true
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
