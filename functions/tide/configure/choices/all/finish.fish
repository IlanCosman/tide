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
            _tide_print_configure_current_options
        case 'Exit and print the config you just generated'
            set -e _tide_selected_option # Skip through all the _next_choices
            command -q clear && clear
            _tide_print_configure_current_options
    end
end

function _tide_finish
    set -e _tide_selected_option # Skip through all the _next_choices

    # Deal with prompt char/vi mode
    contains character $fake_tide_left_prompt_items || set -p fake_tide_left_prompt_items vi_mode

    # Set the real variables
    for fakeVar in (set --names | string match -r "^fake_tide.*")
        set -U (string replace 'fake_' '' $fakeVar) $$fakeVar
    end

    # Make sure old prompt won't display
    set -e $_tide_prompt_var 2>/dev/null

    # Re-initialize the prompt
    source (functions --details fish_prompt)
end

function _tide_print_configure_current_options
    if command -q fish_indent
        printf %s\n "tide configure --auto $_tide_configure_current_options" | fish_indent --ansi
    else
        printf %s\n "tide configure --auto $_tide_configure_current_options"
    end
end
