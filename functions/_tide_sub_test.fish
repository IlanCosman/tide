function _tide_sub_test
    argparse 'h/help' 'v/verbose' 'a/all' 'i/install' -- $argv

    if set -q _flag_help
        _help
        return
    end

    if set -q _flag_install
        # Install fisher and fishtape for testing
        curl git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
        fisher add jorgebucaran/fishtape

        return
    end

    if not functions -q fishtape
        set -l b (set_color -o)
        set -l n (set_color normal)
        printf '%s' $b'fishtape'$n' must be installed to to run Tide\'s test suite. You can install it with'$b' tide test -i'$n
        return
    end

    set -lx TERM xterm # Necessary for testing purposes, ensures color codes are printed

    set -l testsDir "$_tide_dir/tests"

    set -l pending '/tmp/tide_test'
    set -l failed '/tmp/tide_test_failed'
    set -l passed '/tmp/tide_test_passed'

    set -l returnStatement 0

    if set -q _flag_all
        set argv (basename -s '.fish' $testsDir/*)
    end

    for test in $argv
        fishtape "$testsDir/$test.fish" >$pending

        if test $status -eq 0
            if set -q _flag_verbose
                cat $pending >>$passed
            else
                printf '%s\n' "(✔) $test" >>$passed
            end
        else
            cat $pending >>$failed
        end
    end

    if test -e $failed
        printf '%s\n' '--------FAILED--------'
        cat $failed
        rm $failed

        set returnStatement 1
    end
    if test -e $passed
        printf '%s\n' '--------PASSED--------'
        cat $passed
        rm $passed
    end

    if test -e $pending
        rm $pending
    end

    return $returnStatement
end

function _help
    set -l b (set_color -o)
    set -l n (set_color normal)
    set -l g (set_color $_tide_color_green)

    set -l optionList \
        'v or --verbose' \
        'a or --all' \
        'h or --help' \
        'i or --install'
    set -l descriptionList \
        'display test output even if passed' \
        'run all available tests' \
        'print this help message' \
        'install fisher and fishtape test dependencies'

    printf '%s\n' 'Usage: '$g'tide test '$n'[options] '$b'[TESTS...]'$n
    printf '%s\n'
    printf '%s\n' 'Options:'
    printf '%s\n'
    for option in $optionList
        printf '%s' '  -'$option
        printf '%b' '\r'
        _tide_cursor_right 20
        set -l descriptionIndex (contains -i $option $optionList)
        printf '%s\n' $descriptionList[$descriptionIndex]
    end
end