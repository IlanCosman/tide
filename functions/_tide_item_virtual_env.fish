function _tide_item_virtual_env
    set -l split_virtual_env (string split '/' "$VIRTUAL_ENV") &&
        if contains -- $split_virtual_env[-1] virtualenv venv .venv env # avoid generic names
            _tide_print_item virtual_env $tide_virtual_env_icon' ' $split_virtual_env[-2]
        else
            _tide_print_item virtual_env $tide_virtual_env_icon' ' $split_virtual_env[-1]
        end
end
