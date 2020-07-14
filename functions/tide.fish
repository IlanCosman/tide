function tide
    argparse --stop-nonopt 'v/version' -- $argv
    set -l subcommand $argv[1]

    if set -q _flag_version
        printf '%s\n' $_tide_version
        return 0
    end

    set -l actual_command_name "tide_$subcommand"

    if contains $subcommand $_tide_subcommands
        source "$_tide_dir/functions/$subcommand.fish"
        $actual_command_name $argv[2..-1]
    else
        tide help
    end
    functions -e $actual_command_name
end