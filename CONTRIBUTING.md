# Contributing

🌊 Thank you for contributing to Tide! 🌊

## Testing

The `tide test` command runs tests from the `$_tide_dir/tests` folder using [fishtape][]. Currently there are unit tests for most prompt items. You can quickly install fisher and fishtape using `tide test -i`

Example:

```console
tide test status
```

You can run all tests with the `-a` flag.

```console
tide test -a
```

## Git Workflow

1. Fork this repository
2. Make some changes, committing them along the way
3. Create a pull request from your branch to `IlanCosman/tide`

[fishtape]: https://github.com/jorgebucaran/fishtape
