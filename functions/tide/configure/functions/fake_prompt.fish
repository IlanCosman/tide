function fake_prompt
    # Variables are exported as strings, convert _fake_tide_last_pipestatus back into a list
    set -g _fake_tide_last_pipestatus (string split ' ' $_fake_tide_last_pipestatus)

    set -l leftPrompt (_fake_tide_left_prompt)
    set -l leftPromptHeight (count $leftPrompt)
    set -l rightPrompt (_fake_tide_right_prompt)

    if test $leftPromptHeight -gt 1
        if test "$fake_tide_left_prompt_frame_enabled" = true
            set -l frameColor (set_color $fake_tide_left_prompt_frame_color -b normal || echo)
            set leftPrompt[1] $frameColor╭─"$leftPrompt[1]"
            set leftPrompt[2] $frameColor╰─"$leftPrompt[2]"
        end
        if test "$fake_tide_right_prompt_frame_enabled" = true
            set -l frameColor (set_color $fake_tide_right_prompt_frame_color -b normal || echo)
            set rightPrompt[1] "$rightPrompt[1]"$frameColor─╮
            set rightPrompt[2] "$rightPrompt[2]"$frameColor─╯
        end

        printf '%s' $leftPrompt[1]

        set_color $fake_tide_prompt_connection_color
        set -l decoloredTextLength (_tide_decolor "$leftPrompt[1]""$rightPrompt[1]" | string length)
        test -n "$fake_tide_prompt_connection_icon" || set -l fake_tide_prompt_connection_icon ' '
        string repeat --no-newline --max (math $fake_columns - $decoloredTextLength) $fake_tide_prompt_connection_icon

        printf '%s\n' $rightPrompt[1]
    end

    printf '%s' $leftPrompt[-1]
    set -l decoloredTextLength (_tide_decolor "$leftPrompt[-1]""$rightPrompt[$leftPromptHeight]" | string length)
    string repeat --no-newline --max (math $fake_columns - $decoloredTextLength) ' '
    printf '%s' $rightPrompt[$leftPromptHeight]
    set_color normal
end
