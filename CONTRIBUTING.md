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
- Long forms of flags > short forms
  - Exception for `set`, please use short forms
- `test` > `[...]`

Prefer pipes over command substitution when convenient.

Ex:

### Naming Conventions

Local variables should be named in `camelCase`.

- `set -l numberOfNewlines`

Anything exposed to the shell or user--functions, global/universal variables, and files--should be named in `snake_case`, beginning with `tide_`. Prepend an underscore if user interaction is discouraged.

- `set -g _tide_left_prompt_height`
- `set -U tide_right_prompt_items`
- `_tide_count_left_prompt_height.fish`
- `_tide_right_prompt`
- `tide_install`

#### Specific Naming Conventions

- Items begin with `_tide_item_`
- Subcommands begin with `_tide_sub_`

[fishtape]: https://github.com/jorgebucaran/fishtape
