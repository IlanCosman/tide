function tide -a subcommand
    set -l tideSubcommand "tide_$subcommand"
    set -l tideCommands (basename -a -s '.fish' $_tide_dir/functions/*)

    if contains $subcommand $tideCommands
        source "$_tide_dir/functions/$subcommand.fish"
        $tideSubcommand $argv[2..-1]
    else
        tide help
    end
    functions -e $tideSubcommand
end