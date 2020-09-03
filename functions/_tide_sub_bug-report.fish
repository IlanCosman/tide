function _tide_sub_bug-report
    argparse 'v/verbose' -- $argv

    fish --version
    tide --version
    printf '%s\n' $TERM

    if set -q _flag_verbose
        printf '%s\n'
        for var in $_tide_var_list
            printf '%s\n' "$var $$var"
        end
    end
end