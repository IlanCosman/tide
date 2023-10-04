function finish
    _tide_title Finish

    echo
    set_color red
    _tide_option y 'Overwrite your current tide config'
    set_color normal
    echo

    _tide_option p 'Exit and print the config you just generated'
    echo

    _tide_menu (status function)
    switch $_tide_selected_option
        case 'Overwrite your current tide config'
            _tide_finish
            command -q clear && clear
            set -q _flag_auto || _tide_print_configure_current_options
        case 'Exit and print the config you just generated'
            _tide_exit_configure
            command -q clear && clear
            _tide_print_configure_current_options
    end
end

function _tide_finish
    _tide_exit_configure

    # Deal with prompt char/vi mode
    contains character $fake_tide_left_prompt_items || set -p fake_tide_left_prompt_items vi_mode

    # Set the real variables
    for fakeVar in (set --names | string match -r "^fake_tide.*")
        set -U (string replace 'fake_' '' $fakeVar) $$fakeVar
    end

    # Make sure old prompt won't display
    set -e $_tide_prompt_var 2>/dev/null

    # Re-initialize the prompt
    tide reload
end

function _tide_print_configure_current_options
    _tide_fish_colorize "tide configure --auto $_tide_configure_current_options"
end
