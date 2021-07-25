function _tide_init_install --on-event _tide_init_install
    set -U tide_os_icon (_tide_detect_os)
    set -U VIRTUAL_ENV_DISABLE_PROMPT true
    set -U _tide_var_list tide_os_icon VIRTUAL_ENV_DISABLE_PROMPT

    source (functions --details _tide_sub_configure)
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
    set -e $_tide_var_list _tide_var_list $_tide_left_prompt_display_var $_tide_right_prompt_display_var
    functions --erase (functions --all | string match --entire --regex '^_tide_')
end
