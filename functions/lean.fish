function lean -a subcommand
    set -l leanSubcommand "lean_$subcommand"
    set -l leanCommands 'configure' 'uninstall' 'help'

    if contains $subcommand $leanCommands
        source "$lean_dir/functions/$subcommand.fish"
        $leanSubcommand $argv[2..-1]
    else
        lean help
    end
    functions -e $leanSubcommand
end