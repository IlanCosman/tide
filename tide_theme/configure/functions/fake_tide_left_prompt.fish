function _fake_tide_left_prompt
    set lastItemWasNewline # Display prefix instead of separator before first item
    set color normal
    set currentHeight 1

    for item in $fake_tide_left_prompt_items
        if test "$item" = 'newline'
            _tide_print_frame

            if not set -q lastItemWasNewline && not set -q lastItemWasPromptChar
                set_color $previousColor -b normal
                printf '%s' $fake_tide_left_prompt_suffix
            end

            printf '%b' '\n'

            set lastItemWasNewline
            set currentHeight (math $currentHeight +1)

            continue
        end

        set -l output (_fake_tide_item_$item)

        if test -n "$output"
            _tide_print_frame

            set -l colorName fake_tide_"$item"_bg_color
            set -l color $$colorName

            if set -e lastItemWasNewline || set -e lastItemWasPromptChar
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
                printf '%s' " $output"(set_color -b $color)' ' # The set_color is for git_prompt which resets the background color
            else
                printf '%s' "$output"
            end

            set previousColor $color

            if test "$item" = 'prompt_char'
                set lastItemWasPromptChar
            end
        end
    end

    if set -q lastItemWasNewline
        if test "$fake_tide_left_prompt_frame_enabled" = 'true'
            set_color $fake_tide_left_prompt_frame_color
            printf '%s' '╰─'
        end
    else if not set -q lastItemWasPromptChar
        set_color $previousColor -b normal
        printf '%s' $fake_tide_left_prompt_suffix
    end
end

function _tide_print_frame --no-scope-shadowing
    if set -q lastItemWasNewline && test "$fake_tide_left_prompt_frame_enabled" = 'true'
        set_color $fake_tide_left_prompt_frame_color -b normal

        if test $currentHeight -eq 1
            printf '%s' '╭─'
        else if test $currentHeight -lt $_fake_tide_left_prompt_height
            printf '%s' '├─'
        else
            printf '%s' '╰─'
        end
    end
end