set -l uninstallIndex (contains -i uninstall $_tide_subcommands)
set -l subcommandsWithoutUninstall (printf '%s ' $_tide_subcommands[1..(math $uninstallIndex-1)] $_tide_subcommands[(math $uninstallIndex+1)..-1])

# Disable file completions for the entire command
complete -c tide -f

# Offer subcommands if no subcommand has been given so far
complete -c tide -n "not __fish_seen_subcommand_from $subcommandsWithoutUninstall" -a $subcommandsWithoutUninstall