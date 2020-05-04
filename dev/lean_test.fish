function lean_test -a test
    if test $COLUMNS -ne 80 -o $LINES -ne 24
        echo 'Terminal must be exactly 80x24'
        return 1
    end

    clear
    source "$__fish_config_dir/tests/test_$test.fish"
    test_$test $argv[2..-1]
    functions -e test_$test
end