SHELL := /usr/bin/env fish

.PHONY: all
all: fmt lint install test

.PHONY: fmt
fmt:
	@fish_indent --write **/*.fish

.PHONY: lint
lint:
	@for file in **/*.fish; fish --no-execute $$file; end

.PHONY: install
install:
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end
	@fisher install . >/dev/null

littlecheck:
	@curl -sL https://raw.githubusercontent.com/ridiculousfish/littlecheck/HEAD/littlecheck/littlecheck.py -o littlecheck
	@chmod +x littlecheck

.PHONY: test
test: install littlecheck
	@type -q mock || fisher install IlanCosman/clownfish
	@fish tests/test_setup.fish
	@_tide_remove_unusable_items
	@_tide_cache_variables; ./littlecheck --progress tests/*.test.fish
