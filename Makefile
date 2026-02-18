.PHONY: all
all: test plugin-lint

.PHONY: test
test:
	@docker compose run --rm test

.PHONY: plugin-lint
plugin-lint:
	@docker compose run --rm plugin-lint

SHELLCHECK_FILES := $(shell find hooks scripts -type f 2>/dev/null | sort)

.PHONY: shellcheck
shellcheck:
	@docker compose run --rm shellcheck \
		--shell bash --external-sources --color=always --format=gcc \
		$(SHELLCHECK_FILES)

.PHONY: e2e-test
e2e-test:
	@docker compose run --rm e2e-test