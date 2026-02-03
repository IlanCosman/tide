function _tide_item_python
    test -n "$VIRTUAL_ENV"
    or path is .python-version Pipfile __init__.py pyproject.toml requirements.txt setup.py
    or return

    set -l py_cmd python
    command -q python3 && set py_cmd python3
    string match -qr "(?<v>[\d.]+)" -- ($py_cmd --version 2>/dev/null)

    if test -n "$VIRTUAL_ENV"
        string match -qr "^.*/(?<dir>.*)/(?<base>.*)" $VIRTUAL_ENV
        # pipenv $VIRTUAL_ENV looks like /home/ilan/.local/share/virtualenvs/pipenv_project-EwRYuc3l
        # Detect whether we are using pipenv by looking for 'virtualenvs'. If so, remove the hash at the end.
        if test "$dir" = virtualenvs
            string match -qr "(?<base>.*)-.*" $base
            _tide_print_item python $tide_python_icon' ' "$v ($base)"
        else if contains -- "$base" virtualenv venv .venv env # avoid generic names
            _tide_print_item python $tide_python_icon' ' "$v ($dir)"
        else
            _tide_print_item python $tide_python_icon' ' "$v ($base)"
        end
    else
        _tide_print_item python $tide_python_icon' ' $v
    end
end
