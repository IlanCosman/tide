function _tide_item_pyenv
	if test -n "$PYENV_VERSION" \
		-o -f .python-version \
		-o -f requirements.txt \
		-o -f pyproject.toml \
		-o (count *.py) -gt 0
        set -l pyenv_status (pyenv version-name 2>/dev/null) 
        _tide_print_item pyenv $tide_pyenv_icon' ' $pyenv_status 
	end
end
