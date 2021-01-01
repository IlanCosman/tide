function _tide_init_install --on-event _tide_init_install
    _set_immutable _tide_color_dark_blue 0087AF
    _set_immutable _tide_color_dark_green 5FAF00
    _set_immutable _tide_color_gold D7AF00
    _set_immutable _tide_color_green 5FD700
    _set_immutable _tide_color_light_blue 00AFFF

    # Each string replace is the regex equivalent of dirname
    _set_immutable _tide_root (status current-filename | string replace --regex '/[^/]+$' '' | string replace --regex '/[^/]+$' '')

    _set_immutable VIRTUAL_ENV_DISABLE_PROMPT true

    set -U _tide_var_list

    source $_tide_root/functions/_tide_sub_configure.fish
    _load_config 'lean'
    _tide_finish

    status is-interactive && switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
        case y ye yes ''
            tide configure
        case '*'
            printf '%s' \n 'Run ' (set_color $fish_color_command) 'tide ' \
                (set_color $fish_color_param) 'configure ' (set_color normal) 'to customize your prompt.' \n
    end
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    for var in $_tide_var_immutable_list $_tide_var_list
        set -e $var
    end
    set -e _tide_var_immutable_list
    set -e _tide_var_list

    functions --erase (functions --all | string match --entire --regex '^_tide_')
end

function _set_immutable -a var_name
    set -U $var_name $argv[2..-1]
    set -Ua _tide_var_immutable_list $var_name
end
