# Contributing

🌊 Thank you for contributing to Tide! 🌊

Please note that this project is released with a [Code of Conduct][]. By contributing to this project you agree to abide by its terms.

If you have any questions that aren't addressed in this document, please don't hesitate to open an issue!

## Code Conventions

### Style Guide

- `test` > `[...]`
- `printf` > `echo`
- `&&`/`||` > `and`/`or`
- Conditionals
  - For simple conditionals use `&&`/`||`
    - Ex: `test -n "$foo" && echo "foo is not empty"`
    - Ex: `foo || bar || baz`
  - For anything more complex use `if`, `else`, and `else if`
- Long forms of flags > short forms
  - Exceptions: `set`, `set_color`, `function foo -a`, "common knowledge" options for commands like `rm -r`
  - Note that MacOS utils often do not support long flags, in which case one should use the short option
- Piping > command substitution (only when convenient, i.e no extra commands)

### Naming Conventions

- Everything should be in `snake_case`.
- Anything exposed to the user (variables, files, functions) should begin with `tide_`.
- If the user isn't meant to interact with it from the commandline, prepend an underscore.

Examples:

- `set -l color_anchors`
- `set -U tide_right_prompt_items`
- `_tide_detect_os.fish`
- `_tide_print_item`

#### Specific Naming Conventions

- Items begin with `_tide_item_`
- Subcommands begin with `_tide_sub_`

## Makefile

Pretty self explanatory.

- `make all`
- `make fmt`
- `make lint`
- `make install`
- `make test`

In general, just run `make` to do everything.

### Specifics

- [Littlecheck][] - Test driver for command line tools
- [Clownfish][] - Override the behavior of commands
- Code linting is done via [`fish --no-execute`][].
- Markdown and Yaml linting is done via the [Mega-Linter][] action.
- Code formatting is done via [`fish_indent`][].
- Markdown and Yaml formatting is done via [Prettier][].

## Documentation Conventions

All links should be in the [reference style][], with references at the bottom of the document in alphabetical order.

## Release Checklist

- [ ] Update version number in `tide.fish`
- [ ] Put the current date in the changelog
- [ ] Make a commit containing above edits, titled with the version number
- [ ] Create a new tag
- [ ] Push to GitHub

[`fish --no-execute`]: https://fishshell.com/docs/current/cmds/fish.html
[`fish_indent`]: https://fishshell.com/docs/current/cmds/fish_indent.html
[clownfish]: https://github.com/IlanCosman/clownfish
[code of conduct]: CODE_OF_CONDUCT.md
[littlecheck]: https://github.com/ridiculousfish/littlecheck
[mega-linter]: https://github.com/nvuillam/mega-linter
[prettier]: https://github.com/prettier/prettier
[reference style]: https://www.markdownguide.org/basic-syntax/#reference-style-links
