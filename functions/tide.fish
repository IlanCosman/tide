function tide
    argparse --stop-nonopt 'v/version' -- $argv
    set -l subcommand $argv[1]

    if set -q _flag_version
        printf '%s\n' $_tide_version
        return 0
    end

    if functions -q _tide_sub_$subcommand
        _tide_sub_$subcommand $argv[2..-1]
    else
        tide help
    end
end