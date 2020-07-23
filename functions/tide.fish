function tide
    argparse --stop-nonopt 'v/version' 'h/help' -- $argv
    set -l subcommand $argv[1]

    if set -q _flag_version
        printf '%s\n' $_tide_version
        return 0
    end

    if set -q _flag_help
        _tide_help
        return 0
    end

    if functions --query _tide_sub_$subcommand
        _tide_sub_$subcommand $argv[2..-1]
    else
        _tide_help
        return 1
    end
end

function _tide_help
    set -l b (set_color -o)
    set -l n (set_color normal)
    set -l bl (set_color $_tide_color_light_blue)

    set -l options \
        '-v or --version' \
        '-h or --help'
    set -l optionDescriptions \
        'display the current tide version number' \
        'print this help message'

    set -l subcommands \
        'configure' \
        'uninstall' \
        'bug-report' \
        'test'
    set -l subcommandDescriptions \
        'run interactive configuration wizard' \
        'uninstall tide prompt manager' \
        'print tide configuration for use in bug reports' \
        'run tests for developers'

    printf '%s\n' 'Usage: '$bl'tide '$n'[options] '$n$b'subcommand '$n'[options]'
    printf '%s\n'
    printf '%s\n' 'Options:'
    for option in $options
        printf '  %s' $option
        printf '%b' '\r'
        _tide_cursor_right 19 # Should probably make this number smarter, just doing it manually for now
        set -l descriptionIndex (contains --index -- $option $options) # -- is necessary to prevent contains from treating the options as options
        printf '%s\n' $optionDescriptions[$descriptionIndex]
    end
    printf '%s\n'
    printf '%s\n' 'Subcommands:'
    for sub in $subcommands
        printf '  %s' $b$sub$n
        printf '%b' '\r'
        _tide_cursor_right 14
        set -l descriptionIndex (contains --index $sub $subcommands)
        printf '%s\n' $subcommandDescriptions[$descriptionIndex]
    end
end