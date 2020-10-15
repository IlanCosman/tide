complete -c tide -x -n '__fish_use_subcommand' -a --help -d "Print help message"
complete -c tide -x -n '__fish_use_subcommand' -a --version -d "Print tide version"
complete -c tide -x -n '__fish_use_subcommand' -a bug-report -d "Print info for use in bug reports"
complete -c tide -x -n '__fish_use_subcommand' -a configure -d "Run the configuration wizard"
complete -c tide -x -n '__fish_use_subcommand' -a test -d "Run tide tests"

complete -c tide -x -n '__fish_seen_subcommand_from test' -a --all -d "Run all available tests"
complete -c tide -x -n '__fish_seen_subcommand_from test' -a --CI -d "Run tests designed for CI"
complete -c tide -x -n '__fish_seen_subcommand_from test' -a --help -d "Print help message"
complete -c tide -x -n '__fish_seen_subcommand_from test' -a --install -d "Install testing dependencies"
complete -c tide -x -n '__fish_seen_subcommand_from test' -a --verbose -d "Display test output even if passed"

for file in (basename -s .fish $_tide_dir/tests/*.fish)
    complete -c tide -x -n "__fish_seen_subcommand_from test" -a $file
end