set -l subcommands (printf '%s ' (basename -a -s '.fish' $_tide_dir/functions/*))

# Disable file completions for the entire command
complete -c tide -f

# Offer subcommands if no subcommand has been given so far
complete -c tide -n "not __fish_seen_subcommand_from $subcommands" -a $subcommands