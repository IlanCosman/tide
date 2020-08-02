# Contributing

🌊 Thank you for contributing to Tide! 🌊

## Testing

The `tide test` command runs tests from the `$_tide_dir/tests` folder using [fishtape][]. You can quickly install fisher and fishtape using `tide test -i`

Example:

```console
tide test status
```

You can run all tests with the `-a` flag.

```console
tide test -a
```

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

## Linting

Markdown and Yaml linting is done via the [Super-Linter][] action.

## Formatting

Code formatting is done via [fish_indent][].

Markdown and Yaml formatting is done via [Prettier][].

[fishtape]: https://github.com/jorgebucaran/fishtape
[fish_indent]: https://fishshell.com/docs/current/cmds/fish_indent.html
[prettier]: https://github.com/prettier/prettier
[super-linter]: https://github.com/github/super-linter
