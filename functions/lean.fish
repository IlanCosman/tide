function lean -a subcommand
    set -l leanSubCommand "lean_$subcommand"
    set -l leanCommands 'configure' 'test' 'uninstall' 'help'

    if contains $subcommand $leanCommands
        source "$__fish_config_dir/lean_theme/functions/$leanSubCommand.fish"
        $leanSubCommand $argv[2..-1]
    else
        lean help
    end
    functions -e $leanSubCommand
end