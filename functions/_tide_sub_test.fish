function _tide_sub_test
    argparse 'h/help' 'v/verbose' 'a/all' 'i/install' 'c-CI' -- $argv

    if set -q _flag_help
        _tide_test_help
        return 0
    else if set -q _flag_install
        # Install fisher, fishtape, and clownfish for testing
        fisher install jorgebucaran/fishtape IlanCosman/clownfish
        return 0
    else if not functions --query fishtape mock
        set -l b (set_color -o || echo)
        set -l n (set_color normal || echo)
        printf '%s\n' $b'fishtape'$n' and'$b' clownfish'$n' must be installed to to run Tide\'s test suite. You can install them with'$b' tide test -i'$n
        return 1
    end

    set -lx TERM xterm # Ensures color codes are printed

    set -l testsDir "$_tide_root/functions/tide/tests"

    set -q _flag_all && set argv (string replace --all --regex '^.*/|\.fish$' '' $testsDir/*.fish)
    set -q _flag_CI && set -a argv 'CI/'(string replace --all --regex '^.*/|\.fish$' '' $testsDir/CI/*.fish)

    if test (count $argv) -lt 1
        _tide_test_help
        return 1
    end

    sudo --validate # Cache sudo credentials

    set -l pending (mktemp -u)
    set -l failed (mktemp -u)
    set -l passed (mktemp -u)

    for test in $argv
        if fishtape "$testsDir/$test.fish" >$pending
            if set -q _flag_verbose
                cat $pending >>$passed
            else
                printf '%s\n' "(✔) $test" >>$passed
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

        return 1
    end
end

function _tide_test_help
    printf '%s\n' \
        'Usage: tide test [options] [tests]' \
        '' \
        'Options:' \
        '  -v or --verbose  print test output even if passed' \
        '  -a or --all      run all available tests' \
        '  -h or --help     print this help message' \
        '  -i or --install  install testing dependencies' \
        '  --CI             run tests designed for CI'
end