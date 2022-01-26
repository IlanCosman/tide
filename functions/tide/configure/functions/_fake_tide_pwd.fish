function _fake_tide_pwd
    set -g _tide_pwd_len 5
    echo -ns (set_color $fake_tide_pwd_color_dirs)$fake_tide_pwd_icon' ' \
        (set_color -o $fake_tide_pwd_color_anchors)'~'(set_color normal -b $fake_tide_pwd_bg_color) \
        (set_color $fake_tide_pwd_color_dirs)'/'(set_color normal -b $fake_tide_pwd_bg_color) \
        (set_color -o $fake_tide_pwd_color_anchors)'src'(set_color normal -b $fake_tide_pwd_bg_color)
end
