function lean_test
    argparse 'h/help' 'v/verbose' 'a/all' -- $argv

    if set -q _flag_help
        _help
        return 0
    end

    set -l testsDir "$__fish_config_dir/tests"

    set -l pending '/tmp/lean_test'
    set -l failed '/tmp/lean_test_failed'
    set -l passed '/tmp/lean_test_passed'

    if set -q _flag_all
        set argv (basename -s '.fish' $testsDir/*)
    end

    for test in $argv
        fishtape "$testsDir/$test.fish" >$pending

        if test $status -eq 0
            if set -q _flag_verbose
                cat $pending >>$passed
            else
                echo "$test - ✔" >>$passed
            end
        else
            cat $pending >>$failed
        end
    end

    if test -e $passed
        echo '--------PASSED--------'
        cat $passed
        rm $passed
    end
    if test -e $failed
        echo '--------FAILED--------'
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
    set -l g (set_color $lean_color_green)

    set -l optionList \
        'v or --verbose' \
        'a or --all' \
        'h or --help'
    set -l descriptionList \
        'display test output even if passed' \
        'run all available tests' \
        'print this help message'

    echo 'Usage: '$g'lean_test '$n'[options] '$b'[TESTS...]'$n
    echo
    echo 'Options:'
    echo
    for option in $optionList
        echo -n '  -'$option
        _cursor_right 20
        set -l descriptionIndex (contains -i $option $optionList)
        echo $descriptionList[$descriptionIndex]
    end
end