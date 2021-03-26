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

Local variables should be named in `camelCase`.

- `set -l numberOfNewlines`

Anything exposed to the shell or user--functions, global/universal variables, and files--should be named in `snake_case`, beginning with `tide_`. Prepend an underscore if the user in not meant to interact directly with it.

- `set -g _tide_left_prompt_height`
- `set -U tide_right_prompt_items`
- `_tide_count_left_prompt_height.fish`
- `_tide_right_prompt`

#### Specific Naming Conventions

- Items begin with `_tide_item_`
- Subcommands begin with `_tide_sub_`

## Testing

### Dependencies

- [Littlecheck][] - Test driver for command line tools
- [Clownfish][] - Override the behavior of commands

Example:

```console
python littlecheck.py ~/tide/tests/**
```

## Linting

Code linting is done via [`fish --no-execute`][].

Markdown and Yaml linting is done via the [Mega-Linter][] action.

## Formatting

Code formatting is done via [`fish_indent`][].

Markdown and Yaml formatting is done via [Prettier][].

## Documentation Conventions

All links should be in the [reference style][], with references at the bottom of the document in alphabetical order.

## Release

Note that Tide does not use strict semantic versioning.

Todo on release:

- [ ] Update version number in install `tide.fish`
- [ ] Make a commit containing above edit, titled with the version number
- [ ] Create a new tag and push it to GitHub

[`fish --no-execute`]: https://fishshell.com/docs/current/cmds/fish.html
[`fish_indent`]: https://fishshell.com/docs/current/cmds/fish_indent.html
[clownfish]: https://github.com/IlanCosman/clownfish
[code of conduct]: CODE_OF_CONDUCT.md
[littlecheck]: https://github.com/ridiculousfish/littlecheck
[mega-linter]: https://github.com/nvuillam/mega-linter
[prettier]: https://github.com/prettier/prettier
[reference style]: https://www.markdownguide.org/basic-syntax/#reference-style-links
