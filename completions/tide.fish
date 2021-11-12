complete tide --no-files

set -l subcommands bug-report configure

complete tide -x -n __fish_use_subcommand -a bug-report -d "Print info for use in bug reports"
complete tide -x -n __fish_use_subcommand -a configure -d "Run the configuration wizard"

complete tide -x -n "not __fish_seen_subcommand_from $subcommands" -s h -l help -d "Print help message"
complete tide -x -n "not __fish_seen_subcommand_from $subcommands" -s v -l version -d "Print tide version"

complete tide -x -n '__fish_seen_subcommand_from bug-report' -l clean -d "Run clean Fish instance and install Tide"
complete tide -x -n '__fish_seen_subcommand_from bug-report' -l verbose -d "Print full Tide configuration"
