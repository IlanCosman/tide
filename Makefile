SHELL := /usr/bin/env fish

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z -]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

littlecheck:
	@echo "Downloading littlecheck.py..."
	@curl -fsSL https://raw.githubusercontent.com/ridiculousfish/littlecheck/master/littlecheck/littlecheck.py -o littlecheck
	@chmod +x littlecheck

.PHONY: fmt
fmt: ## Format codebase
	@fish_indent -w **/*.fish

.PHONY: lint
lint: ## Lint codebase
	@echo **/*.fish | xargs -n1 fish --no-execute

.PHONY: test
test: littlecheck ## Run tests
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end
	@type -q mock || fisher install IlanCosman/clownfish
	@fisher install . >/dev/null
	@fish tests/test_setup.fish
	@./littlecheck --progress tests/*.test.fish
