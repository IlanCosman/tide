set -l subcommands (basename -s '.fish' $__fish_config_dir/functions/_tide_sub_* | string replace '_tide_sub_' '')
set -l uninstallIndex (contains --index uninstall $subcommands)
set -l subcommandsWithoutUninstall (printf '%s ' $subcommands[1..(math $uninstallIndex-1)] $subcommands[(math $uninstallIndex+1)..-1])

# Disable file completions for the entire command
complete --command tide --no-files

# Offer subcommands (without uninstall) if no subcommand has been given so far
complete --command tide --condition "not __fish_seen_subcommand_from $subcommands" --arguments=$subcommandsWithoutUninstall