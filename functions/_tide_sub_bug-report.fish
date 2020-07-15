function _tide_sub_bug-report
    for var in $_tide_var_list
        printf '%s\n' "$var $$var"
    end
end