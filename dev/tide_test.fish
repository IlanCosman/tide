function tide_test
    argparse 'h/help' 'v/verbose' 'a/all' -- $argv

    if set -q _flag_help
        _help
        return 0
    end

    set -l testsDir "$__fish_config_dir/tests"

    set -l pending '/tmp/tide_test'
    set -l failed '/tmp/tide_test_failed'
    set -l passed '/tmp/tide_test_passed'

    if set -q _flag_all
        set argv (basename -s '.fish' $testsDir/*)
    end

    for test in $argv
        fishtape "$testsDir/$test.fish" >$pending

        if test $status -eq 0
            if set -q _flag_verbose
                cat $pending >>$passed
            else
                printf '%s\n' "$test - ✔" >>$passed
            end
        else
            cat $pending >>$failed
        end
    end

    if test -e $passed
        printf '%s\n' '--------PASSED--------'
        cat $passed
        rm $passed
    end
    if test -e $failed
        printf '%s\n' '--------FAILED--------'
        cat $failed
        rm $failed
    end
    if test -e $pending
        rm $pending
    end
end

function _help
    set -l b (set_color -o)
    set -l n (set_color normal)
    set -l g (set_color $_tide_color_green)

    set -l optionList \
        'v or --verbose' \
        'a or --all' \
        'h or --help'
    set -l descriptionList \
        'display test output even if passed' \
        'run all available tests' \
        'print this help message'

    printf '%s\n' 'Usage: '$g'tide_test '$n'[options] '$b'[TESTS...]'$n
    printf '%s\n'
    printf '%s\n' 'Options:'
    printf '%s\n'
    for option in $optionList
        printf '%s' '  -'$option
        _cursor_right 20
        set -l descriptionIndex (contains -i $option $optionList)
        printf '%s\n' $descriptionList[$descriptionIndex]
    end
end