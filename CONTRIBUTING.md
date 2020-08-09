# Contributing

🌊 Thank you for contributing to Tide! 🌊

Please note that this project is released with a [Code of Conduct][]. By contributing to this project you agree to abide by its terms.

If you have any questions that aren't addressed in this document, please don't hesitate to open an issue!

## Code Conventions

### Style Guide

- `if` > `and` or `or`
- `test` > `[...]`
- `printf` > `echo`
- Long forms of flags > short forms
  - Exceptions: `set`, `set_color`, `function foo -a`, "common knowledge" options for commands like `rm -r`
- Piping > command substitution (only when convenient, i.e no extra commands)

### Naming Conventions

Local variables should be named in `camelCase`.

- `set -l numberOfNewlines`

Anything exposed to the shell or user--functions, global/universal variables, and files--should be named in `snake_case`, beginning with `tide_`. Prepend an underscore if the user in not meant to interact directly with it.

- `set -g _tide_left_prompt_height`
- `set -U tide_right_prompt_items`
- `_tide_count_left_prompt_height.fish`
- `_tide_right_prompt`
- `tide_install`

#### Specific Naming Conventions

- Items begin with `_tide_item_`
- Subcommands begin with `_tide_sub_`

## Testing

`tide test` runs tests from the `$_tide_dir/tests` folder using [fishtape][]. You can quickly install fisher and fishtape using `tide test -i`.

Example:

```console
tide test status
```

You can run the full test suite with the `-a/--all` flag.

```console
tide test -a
```

## Linting

Code linting is done via [`fish --no-execute`][].

Markdown and Yaml linting is done via the [Super-Linter][] action, which uses [Markdownlint][] and [Yamllint][].

## Formatting

Code formatting is done via [`fish_indent`][].

Markdown and Yaml formatting is done via [Prettier][].

## Documentation Conventions

All links should be in the [reference style][], with references at the bottom of the document in alphabetical order.

## Versioning

Tide does not use strict semantic versioning but instead whatever feels appropriate at the moment.

For example Tide may:

- Not update the patch version number for minor fixes
- Bump the major version number for a large feature even if it's backwards compatible

[code of conduct]: CODE_OF_CONDUCT.md
[fishtape]: https://github.com/jorgebucaran/fishtape
[`fish --no-execute`]: https://fishshell.com/docs/current/cmds/fish.html
[`fish_indent`]: https://fishshell.com/docs/current/cmds/fish_indent.html
[markdownlint]: https://github.com/DavidAnson/markdownlint
[prettier]: https://github.com/prettier/prettier
[reference style]: https://www.markdownguide.org/basic-syntax/#reference-style-links
[super-linter]: https://github.com/github/super-linter
[yamllint]: https://github.com/adrienverge/yamllint
