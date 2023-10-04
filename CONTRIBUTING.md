# Contributing

🌊 Thank you for contributing to Tide! 🌊

If you have any questions that aren't addressed in this document, please don't hesitate to open an issue!

## Code Conventions

### Style Guide

- `test` > `[...]`
- `&&`/`||` > `and`/`or`
- Conditionals
  - For simple conditionals use `&&`/`||`
    - Ex: `test -n "$foo" && echo "foo is not empty"`
    - Ex: `foo || bar || baz`
  - For anything more complex use `if`, `else`, and `else if`
- Piping > command substitution (only when convenient, i.e no extra commands)

### Naming Conventions

- Everything should be in `snake_case`.
- Anything exposed to the user (variables, files, functions) should begin with `tide_`.
- If the user isn't meant to interact with it from the commandline, prepend an underscore.

Examples:

- `set -l split_pwd`
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

### Images

- Gnome DE
- Blackbox terminal
  - Show Header Bar: off
  - Padding: 12
  - Default color scheme
- Stitches: Dont stack frames, output image quality 100

#### Specifics

- Header: 13pt, 55x16
- Configuration Wizard: 17pt, 70x21
  - Stitch delays:
  - | 80  | 10  | 10  | 10  | 10  | 14  | 10  | 30  |
    | --- | --- | --- | --- | --- | --- | --- | --- |
    | 80  | 110 | 110 | 110 | 110 | 110 | 110 | 110 |
    | 110 | 110 | 110 | 110 | 300 |     |     |     |
- Flexible: 13pt, 56x4
- Extendable: 13pt, 55x9
- PWD: 17pt, 42x14

## Release Checklist

- [ ] Update version number in `tide.fish`
- [ ] Put the current date in the changelog
- [ ] Make a commit containing above edits, titled with the version number
- [ ] Create a new tag
- [ ] Push to GitHub

[`fish --no-execute`]: https://fishshell.com/docs/current/cmds/fish.html
[`fish_indent`]: https://fishshell.com/docs/current/cmds/fish_indent.html
[clownfish]: https://github.com/IlanCosman/clownfish
[littlecheck]: https://github.com/ridiculousfish/littlecheck
[mega-linter]: https://github.com/nvuillam/mega-linter
[prettier]: https://github.com/prettier/prettier
[reference style]: https://www.markdownguide.org/basic-syntax/#reference-style-links
