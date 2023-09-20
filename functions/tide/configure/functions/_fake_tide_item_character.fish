function _fake_tide_item_character
    set_color $fake_tide_character_color
    if contains newline $fake_tide_left_prompt_items || set -q _configure_transient
        echo -ns $fake_tide_character_icon
    else
        echo -ns ' '$fake_tide_character_icon
    end
end
