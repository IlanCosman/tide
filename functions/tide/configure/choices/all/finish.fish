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
    # Remove tool-specific items for tools the machine doesn't have installed
    set -l generalItems cmd_duration context jobs os prompt_char pwd status time vi_mode
    set -l toolSpecificItems (functions --all | string replace --filter --regex "^_tide_item_" '')
    for item in $generalItems
        _find_and_remove $item toolSpecificItems
    end

    for item in $toolSpecificItems
        set -l cliName $item
        switch $item
            case virtual_env
                set cliName python
            case rust
                set cliName rustc
        end

        if not type -q $cliName
            _find_and_remove $item fake_tide_left_prompt_items
            _find_and_remove $item fake_tide_right_prompt_items
        end
    end

    # Deal with prompt char/vi mode
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

    # Finally, set the real variables
    for fakeVar in (set --names | string match --regex "^fake_tide.*")
        set -U (string replace 'fake_' '' $fakeVar) $$fakeVar
    end
end
