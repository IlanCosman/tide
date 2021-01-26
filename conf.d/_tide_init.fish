function _tide_init_install --on-event _tide_init_install
    set -U _tide_var_list

    # Tiny improvment to shell startup, which makes async faster
    function _tide_set -a var_name
        set -U $var_name $argv[2..-1]
        set -a _tide_var_list $var_name
    end

    _tide_set _tide_color_dark_blue 0087AF
    _tide_set _tide_color_dark_green 5FAF00
    _tide_set _tide_color_gold D7AF00
    _tide_set _tide_color_green 5FD700
    _tide_set _tide_color_light_blue 00AFFF

    # Each string replace is kind of dirname
    _tide_set _tide_root (status filename | string replace --regex '/[^/]+$' '' | string replace --regex '/[^/]+$' '')

    _tide_set VIRTUAL_ENV_DISABLE_PROMPT true

    source $_tide_root/functions/tide/configure/choices/all/style.fish
    _load_config 'lean'
    for fakeVar in (set --names | string match --regex "^fake_tide.*")
        set -l normalVar (string replace 'fake_' '' $fakeVar)
        set -a _tide_var_list $normalVar
        set -U $normalVar $$fakeVar
    end

    status is-interactive && switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
        case y ye yes ''
            tide configure
        case '*'
            printf '%s' \n 'Run ' (set_color $fish_color_command) 'tide ' \
                (set_color $fish_color_param) 'configure ' (set_color normal) 'to customize your prompt.' \n
    end
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    for var in $_tide_var_list
        set -e $var
    end
    set -e _tide_var_list

    functions --erase (functions --all | string match --entire --regex '^_tide_')
end
