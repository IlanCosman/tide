function _tide_vscode_wrap_prompt
    test "$VSCODE_INJECTION" = 1 || return 1
    functions --query __vsc_fish_prompt || return 1
    functions --query __vsc_fish_prompt_start || return 1
    functions --query __vsc_fish_cmd_start || return 1

    # VSCode appends its command-start marker after fish_prompt output. Strip
    # Tide's trailing newline so that marker stays on the prompt line without
    # collapsing Tide's own internal newline for two-line prompts.
    function fish_prompt
        __vsc_fish_prompt_start
        printf '%s' (__vsc_fish_prompt | string collect --allow-empty)
        __vsc_fish_cmd_start
    end
end
