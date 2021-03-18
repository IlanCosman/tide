function finish
    set_color red
    _tide_title 'Overwrite tide config?'
    set_color normal

    _tide_option y Yes
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
    # Deal with prompt char/vi mode
    if contains prompt_char $fake_tide_left_prompt_items
        _tide_find_and_remove vi_mode fake_tide_right_prompt_items
    else
        # If no prompt_char, insert vi_mode
        _tide_find_and_remove vi_mode fake_tide_right_prompt_items
        if contains time $fake_tide_right_prompt_items
            set fake_tide_right_prompt_items $fake_tide_right_prompt_items[1..-2] vi_mode $fake_tide_right_prompt_items[-1]
        else
            set -a fake_tide_right_prompt_items vi_mode
        end
    end

    # Finally, set the real variables
    for fakeVar in (set --names | string match --regex "^fake_tide.*")
        set -U (string replace 'fake_' '' $fakeVar) $$fakeVar
    end

    _tide_remove_unusable_items
end
