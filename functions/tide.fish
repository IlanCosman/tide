function tide
    argparse 'v/version' -- $argv
    set -l subcommand $argv[1]

    if set -q _flag_version
        printf '%s\n' $_tide_version
        return 0
    end

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