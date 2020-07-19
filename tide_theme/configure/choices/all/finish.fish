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
            if not contains 'prompt_char' $fake_tide_left_prompt_items # Without a prompt_char, the user won't know if a command failed/succeeded
                set fake_tide_status_always_display_icon true # Therefore, set the status to always display
            end

            cat "$_tide_dir/configure/fish_prompt.fish" >"$__fish_config_dir/functions/fish_prompt.fish"

            for normalVar in (string replace 'fake_' '' $fake_tide_var_list)
                set fakeVar fake_$normalVar
                set -U $normalVar $$fakeVar
            end
            set _tide_var_list $fake_tide_var_list

            source "$__fish_config_dir/conf.d/_tide_Ω_init.fish" # Reload important startup variables
    end

    _tide_quit
end
