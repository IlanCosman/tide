function _tide_sub_help -a subcommand
    set -g b (set_color -o)
    set -g n (set_color normal)
    set -g g (set_color $_tide_color_green)

    set -g subcommandList \
        'configure' \
        'uninstall' \
        'bug-report' \
        'help'
    set -g descriptionList \
        'run interactive configuration wizard' \
        'uninstall tide theme' \
        'print tide configuration for use in bug reports' \
        'print this help message'

    if contains $subcommand $subcommandList
        if functions -q _help_$subcommand
            _help_$subcommand
        else
            _tide_generic_help_sub $subcommand
        end
        return 0
    end

    printf '%s\n' 'Usage: '$g'tide '$n$b'subcommand '$n'[options]'
    printf '%s\n'
    printf '%s\n' 'Subcommands:'
    printf '%s\n'
    for sub in $subcommandList
        printf '%s' '  '$b$sub$n
        printf '%b' '\r'
        _tide_cursor_right 14
        _tide_get_description $sub
    end
    printf '%s\n'
    printf '%s\n' 'Print help for a specific subcommand:'
    printf '%s\n'
    printf '%s\n' '  '$g'tide '$n'help '$b'subcommand'$n

    set -a rmVars b n g subcommandList descriptionList
    for var in $rmVars
        set -e $var
    end
end

function _tide_get_description -a subcommand
    set -l descriptionIndex (contains -i $subcommand $subcommandList)
    printf '%s\n' $descriptionList[$descriptionIndex]
end

function _tide_generic_help_sub -a subcommand
    set -l description (_tide_get_description $subcommand)
    set -l descriptionFirstLetter (string sub -l 1 $description)
    set -l upperDescriptionFirstLetter (string upper $descriptionFirstLetter)

    printf '%s\n' 'Usage: '$g'tide '$n$b$subcommand$n
    printf '%s\n'
    string replace $descriptionFirstLetter $upperDescriptionFirstLetter $description
end