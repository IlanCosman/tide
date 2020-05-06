function lean_test -a test
    if test $COLUMNS -ne 80 -o $LINES -ne 24
        echo 'Terminal must be exactly 80x24'
        return 1
    end

    set -l testFile "$__fish_config_dir/tests/$test.fish"
    set -l testFileFirstLine (head -n 1 $testFile)

    if test "$testFileFirstLine" = '# Fishtape test'
        fishtape $testFile
        return 0
    end

    pushd .
    source $testFile
    test_$test $argv[2..-1]
    functions -e test_$test
    popd
end