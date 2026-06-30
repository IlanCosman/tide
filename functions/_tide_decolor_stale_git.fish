function _tide_decolor_stale_git -a prompt
    set -l git_start __tide_git_start
    set -l git_end __tide_git_end
    set -l stale_marker __tide_prompt_stale
    set -l prompt_is_stale false

    if string match -q "$stale_marker*" -- $prompt
        set prompt (string replace -m1 $stale_marker '' -- $prompt)
        set prompt_is_stale true
    end

    if test "$prompt_is_stale" != true; or not set -q _tide_git_stale_color
        string replace -a $git_start '' -- $prompt | string replace -a $git_end ''
        return
    end

    printf '\e' | read -l esc
    set -l color_pattern "$esc"'(\[[0-9;:]*[A-Za-z]|\(B)'
    set -l output

    while string match -q "*$git_start*$git_end*" -- $prompt
        set -l start_parts (string split -m1 $git_start -- $prompt)
        set -l end_parts (string split -m1 $git_end -- $start_parts[2])
        set -l git_text (string replace -ra $color_pattern '' -- $end_parts[1])

        set output (string join '' -- $output $start_parts[1] $_tide_git_stale_color $git_text)
        set prompt $end_parts[2]
    end

    string join '' -- $output $prompt
end
