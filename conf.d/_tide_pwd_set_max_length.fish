function _tide_pwd_set_max_length -v tide_pwd_truncate_margin -s WINCH
    set -g _tide_pwd_max_length (math $COLUMNS-$tide_pwd_truncate_margin)

    _tide_pwd
end