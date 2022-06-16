function _fake_tide_pwd
    set -l out (
        set_color $fake_tide_pwd_color_dirs
        echo -ns $fake_tide_pwd_icon' ' '~/'
        set_color -o $fake_tide_pwd_color_anchors
        echo -ns src
        set_color normal -b $fake_tide_pwd_bg_color
    )
    set -g _tide_pwd_len (string length --visible $out)
    echo -ns $out
end
