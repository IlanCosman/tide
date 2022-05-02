function tide --description 'Manage your Tide prompt'
    argparse --stop-nonopt v/version h/help -- $argv

    if set -q _flag_version
        echo 'tide, version 5.3.0'
    else if set -q _flag_help
        _tide_help
    else if functions --query _tide_sub_$argv[1]
        _tide_sub_$argv[1] $argv[2..]
    else
        _tide_help
        return 1
    end
end

function _tide_help
    printf %s\n \
        'Usage: tide [options] subcommand [options]' \
        '' \
        'Options:' \
        '  -v or --version  print tide version number' \
        '  -h or --help     print this help message' \
        '' \
        'Subcommands:' \
        '  configure   run interactive configuration wizard' \
        '  bug-report  print info for use in bug reports'
end
