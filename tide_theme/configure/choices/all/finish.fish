function finish
    set_color red
    _title 'Overwrite tide config and fish_prompt?'
    # set_color normal

    _option y 'Yes'
    printf '%b' '\n\n'

    _option n 'No'
    printf '%b' '\n\n'

    switch (_menu 'Choice' y/n)
        case y
            for var in $_tide_var_list
                set -e $var
            end
            set _tide_var_list

            for fakeVar in $fake_tide_var_list
                set -l normalVar (string replace 'fake_' '' $fakeVar)
                set -U $normalVar $$fakeVar
                set -a _tide_var_list $normalVar
                set -e $fakeVar
            end

            cd .
    end

    _quit
end
