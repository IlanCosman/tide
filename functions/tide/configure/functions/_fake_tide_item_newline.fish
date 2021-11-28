function _fake_tide_item_newline
    set_color $prev_bg_color -b normal
    var=fake_tide_"$_fake_tide_side"_prompt_suffix echo $$var
    set -g add_prefix
end
