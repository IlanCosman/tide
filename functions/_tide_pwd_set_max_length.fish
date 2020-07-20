function _tide_pwd_set_max_length --on-variable tide_pwd_truncate_margin --on-signal WINCH
    set -g _tide_pwd_max_length (math $COLUMNS -$tide_pwd_truncate_margin)

    _tide_pwd
end