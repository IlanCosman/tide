function _fake_tide_left_prompt
    set -l lastItem newline

    for item in $fake_tide_left_prompt_items
        if test "$item" = newline
            set_color $previousColor -b normal
            printf '%s' $fake_tide_left_prompt_suffix\n
        else
            set -l output (_fake_tide_item_$item)
            test -n "$output" || continue

            set -l colorName fake_tide_"$item"_bg_color
            set -l color $$colorName

            if test "$lastItem" = newline
                if test "$item" != prompt_char
                    set_color $color -b normal
                    printf '%s' $fake_tide_left_prompt_prefix
                end
            else if test "$color" = "$previousColor"
                set_color $fake_tide_left_prompt_item_separator_same_color_color
                printf '%s' $fake_tide_left_prompt_item_separator_same_color
            else
                set_color $previousColor -b $color
                printf '%s' $fake_tide_left_prompt_item_separator_diff_color
            end

            set_color -b $color

            if test "$fake_tide_left_prompt_pad_items" = true -a "$item" != prompt_char
                printf '%s' " $output "
            else
                printf '%s' "$output"
            end

            set previousColor $color
        end
        set lastItem $item
    end

    if test "$lastItem" != newline -a "$lastItem" != prompt_char
        set_color $previousColor -b normal
        printf '%s' $fake_tide_left_prompt_suffix
    end

    set_color normal
end
