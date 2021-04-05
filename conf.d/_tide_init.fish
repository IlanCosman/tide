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
    _tide_set _tide_root (status dirname)/..
    _tide_set _tide_os_icon (_tide_detect_os)
    _tide_set VIRTUAL_ENV_DISABLE_PROMPT true

    source $_tide_root/functions/tide/configure/choices/all/style.fish
    source $_tide_root/functions/tide/configure/choices/all/finish.fish
    _load_config lean
    _tide_finish
    set -a _tide_var_list (set --names | string match --regex "^tide.*")

    status is-interactive && switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
        case y ye yes ''
            tide configure
        case '*'
            printf '%s' \n 'Run ' (printf '%s' "tide configure" | fish_indent --ansi) ' to customize your prompt.' \n
    end
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    set -e $_tide_var_list _tide_var_list
    functions --erase (functions --all | string match --entire --regex '^_tide_')
end
