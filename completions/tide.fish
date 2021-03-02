complete tide --no-files

complete tide -x -n __fish_use_subcommand -a --help -d "Print help message"
complete tide -x -n __fish_use_subcommand -a --version -d "Print tide version"
complete tide -x -n __fish_use_subcommand -a bug-report -d "Print info for use in bug reports"
complete tide -x -n __fish_use_subcommand -a configure -d "Run the configuration wizard"

complete tide -x -n '__fish_seen_subcommand_from bug-report' -a --clean -d "Run clean Fish instance and install Tide"
complete tide -x -n '__fish_seen_subcommand_from bug-report' -a --verbose -d "Print full Tide configuration"
