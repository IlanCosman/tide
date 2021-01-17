function _fake_tide_left_prompt
    set lastItemWasNewline

    for item in $fake_tide_left_prompt_items
        if test "$item" = 'newline'
            set_color $previousColor -b normal
            printf '%s' $fake_tide_left_prompt_suffix\n
            set lastItemWasNewline
            set alreadyOneNewline
        else
            set -l output (_fake_tide_item_$item)
            if test -n "$output"
                set -l colorName fake_tide_"$item"_bg_color
                set -l color $$colorName
                test -n "$color" || set color normal

                if set -e lastItemWasNewline
                    if test "$fake_tide_left_prompt_frame_enabled" = 'true'
                        set_color $fake_tide_left_prompt_frame_color -b normal
                        if set -q alreadyOneNewline
                            printf '%s' '╰─'
                        else
                            printf '%s' '╭─'
                        end
                    end

                    if test "$item" != 'prompt_char'
                        set_color $color -b normal
                        printf '%s' $fake_tide_left_prompt_prefix
                    end
                else
                    if test "$color" = "$previousColor"
                        set_color $fake_tide_left_prompt_item_separator_same_color_color
                        printf '%s' $fake_tide_left_prompt_item_separator_same_color
                    else
                        set_color $previousColor -b $color
                        printf '%s' $fake_tide_left_prompt_item_separator_diff_color
                    end
                end

                set_color -b $color

                if test "$fake_tide_left_prompt_pad_items" = 'true' -a "$item" != 'prompt_char'
                    printf '%s' " $output "
                else
                    printf '%s' "$output"
                end

                set previousColor $color

                test "$item" = 'prompt_char' && set lastItemWasPromptChar
            end
        end
    end

    if set -q lastItemWasNewline && test "$fake_tide_left_prompt_frame_enabled" = 'true'
        set_color $fake_tide_left_prompt_frame_color -b normal
        printf '%s' '╰─'
    else if not set -q lastItemWasPromptChar
        set_color $previousColor -b normal
        printf '%s' $fake_tide_left_prompt_suffix
    end
end