function finish
    set_color red
    _tide_title 'Overwrite tide config?'
    set_color normal

    _tide_option y 'Yes'
    printf '%b' '\n'

    _tide_menu
    switch $_tide_selected_option
        case y
            _tide_finish
    end

    __tide_on_fish_exit
    clear
end

function _tide_finish
    if contains 'prompt_char' $fake_tide_left_prompt_items
        _find_and_remove vi_mode fake_tide_right_prompt_items
    else
        set fake_tide_status_always_display true # Without a prompt_char, the user won't know if a command failed/succeeded

        # If no prompt_char, insert vi_mode
        _find_and_remove vi_mode fake_tide_right_prompt_items
        if contains 'time' $fake_tide_right_prompt_items
            set fake_tide_right_prompt_items $fake_tide_right_prompt_items[1..-2] 'vi_mode' $fake_tide_right_prompt_items[-1]
        else
            set -a fake_tide_right_prompt_items 'vi_mode'
        end
    end

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
end
