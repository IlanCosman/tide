function lean_help -a subcommand
    set -g b (set_color -o)
    set -g n (set_color normal)
    set -g g (set_color $lean_color_green)

    set -g subcommandList \
        'configure' \
        'uninstall' \
        'help'
    set -g descriptionList \
        'run interactive configuration wizard' \
        'uninstall lean theme' \
        'print this help message'

    if contains $subcommand $subcommandList
        if functions -q _help_$subcommand
            _help_$subcommand
        else
            _generic_help_sub $subcommand
        end
        return 0
    end

    echo 'Usage: '$g'lean '$n$b'subcommand '$n'[options]'
    echo
    echo 'Subcommands:'
    echo
    for sub in $subcommandList
        echo -n '  '$b$sub$n
        printf '\r\033[14C'
        _getDescription $sub
    end
    echo
    echo 'Print help for a specific subcommand:'
    echo
    echo '  '$g'lean '$n'help '$b'subcommand'$n

    set -a rmVars b n g subcommandList descriptionList
    for var in $rmVars
        set -e $var
    end
end

function _getDescription -a subcommand
    set -l descriptionIndex (contains -i $subcommand $subcommandList)
    echo $descriptionList[$descriptionIndex]
end

function _generic_help_sub -a subcommand
    set -l description (_getDescription $subcommand)
    set -l descriptionFirstLetter (string sub -l 1 $description)
    set -l upperDescriptionFirstLetter (string upper $descriptionFirstLetter)

    echo 'Usage: '$g'lean '$n$b$subcommand$n
    echo
    string replace $descriptionFirstLetter $upperDescriptionFirstLetter $description
end