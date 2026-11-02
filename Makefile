SHELL := /usr/bin/env fish

.PHONY: all
all: fmt lint install test

.PHONY: fmt
fmt:
	@fish_indent --write **.fish

.PHONY: lint
lint:
	@for file in **.fish; fish --no-execute $$file; end

.PHONY: install
install:
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end
	@fisher install . >/dev/null

littlecheck.py:
	@curl -sL https://raw.githubusercontent.com/ridiculousfish/littlecheck/HEAD/littlecheck/littlecheck.py -o littlecheck.py

# Test in a throwaway fish config, deleted afterwards even on failure or Ctrl-C
.PHONY: test
test: littlecheck.py
	@set -gx XDG_CONFIG_HOME (mktemp -d) || exit; set -e fisher_path; \
	function _tide_test_cleanup --on-event fish_exit --on-signal INT; rm -rf $$XDG_CONFIG_HOME; end; \
	$(MAKE) --no-print-directory _test

.PHONY: _test
_test: install
	@type -q mock || fisher install IlanCosman/clownfish
	@fish tests/test_setup.fish
	@_tide_remove_unusable_items
	@_tide_cache_variables; python3 littlecheck.py --progress tests/**.test.fish

.PHONY: clean
clean:
	@rm littlecheck.py
