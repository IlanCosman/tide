function _fake_tide_item_character
    set_color $fake_tide_character_color
    contains newline $fake_tide_left_prompt_items || echo -ns ' '
    echo -ns $fake_tide_character_icon
end
