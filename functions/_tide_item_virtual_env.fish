function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        # Avoid printing a generic name
        if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
            _tide_print_item virtual_env $splitVirtualEnv[-2]
        else
            _tide_print_item virtual_env $splitVirtualEnv[-1]
        end
    end
end
