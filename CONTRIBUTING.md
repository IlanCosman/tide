# Contributing

🌊 Thank you for contributing to Tide! 🌊

## Installing for Developers

The `tide_install` function offers a few flags. `-d` will install Tide as a developer which provides extra files for testing. `-l` will install Tide from a local directory. When installing remotely, `tide_install` takes a branch name as an argument, defaulting to master.

Examples:

```fish
tide_install -d example-branch
```

```fish
tide_install -ld ~/tide
```

## Testing

The `tide_test` command runs tests from the `$__fish_config_dir/tests` folder using [fishtape][]. Currently there are unit tests for most prompt items.

Example:

```fish
tide_test status
```

## Git Workflow

1. Fork this repository
2. Make some changes, committing them along the way
3. Create a pull request from your branch to `IlanCosman/tide`

[fishtape]: https://github.com/jorgebucaran/fishtape
