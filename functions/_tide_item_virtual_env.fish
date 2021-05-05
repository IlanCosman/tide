function _tide_item_virtual_env
    set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV") && if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
        _tide_print_item virtual_env $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
    else
        _tide_print_item virtual_env $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
    end
end
