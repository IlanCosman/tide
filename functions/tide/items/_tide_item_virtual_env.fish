function _tide_item_virtual_env
    test -n "$VIRTUAL_ENV" && split_virtual_env=(string split / "$VIRTUAL_ENV") if test $split_virtual_env[-2] = virtualenvs
        # pipenv $VIRTUAL_ENV looks like /home/ilan/.local/share/virtualenvs/pipenv_project-EwRYuc3l
        # Detect whether we are using pipenv by looking for virtualenvs. If so, remove the hash at the end.
        _tide_print_item virtual_env $tide_virtual_env_icon' ' (string split -r -m1 - "$split_virtual_env[-1]")[1]
    else if contains -- $split_virtual_env[-1] virtualenv venv .venv env # avoid generic names
        _tide_print_item virtual_env $tide_virtual_env_icon' ' $split_virtual_env[-2]
    else
        _tide_print_item virtual_env $tide_virtual_env_icon' ' $split_virtual_env[-1]
    end
end
