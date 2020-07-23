function finish
    set_color red
    _tide_title 'Overwrite tide config and fish_prompt?'
    set_color normal

    _tide_option y 'Yes'
    printf '%b' '\n\n'

    _tide_option n 'No'
    printf '%b' '\n\n'

    switch (_tide_menu)
        case y
            _tide_finish
    end

    _tide_quit
end

function _tide_finish
    block --global # Event blocker prevents issues from arising while variables might be undefined etc.

    if not contains 'prompt_char' $fake_tide_left_prompt_items # Without a prompt_char, the user won't know if a command failed/succeeded
        set fake_tide_status_always_display true # Therefore, set the status to always display
    end

    cat "$_tide_dir/configure/fish_prompt.fish" >"$__fish_config_dir/functions/fish_prompt.fish"

    # Delete all vars in _tide_var_list and all non fake fish_git_prompt vars
    for var in $_tide_var_list (set -n | string match --invert --entire 'fake' | string match --entire fish_git_prompt)
        set -e $var
    end

    set -l incomingVarList (string replace 'fake_' '' $fake__tide_var_list)

    for normalVar in $incomingVarList
        set -l fakeVar fake_$normalVar
        set -U $normalVar $$fakeVar
    end

    set _tide_var_list $incomingVarList

    source "$__fish_config_dir/conf.d/_tide_Ω_init.fish" # Reload important startup variables

    block --erase
end