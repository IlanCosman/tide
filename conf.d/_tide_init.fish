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

function _tide_init_update --on-event _tide_init_update
    # v5 introduced tide_prompt_min_cols. Only proceed if older than v5
    set --query tide_prompt_min_cols && return

    # Save old vars to tmp file
    set -l tmp (mktemp -t tide_old_config.XXXXX)
    tide bug-report --verbose >$tmp

    # Delete old vars
    set -e $_tide_var_list _tide_var_list $_tide_prompt_var

    # Print a warning
    set_color yellow
    echo "You have upgraded to version 5 of Tide."
    echo "Since there are breaking changes, your old configuraton has been saved in:"
    set_color normal
    echo $tmp

    sleep 5

    _tide_init_install
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    set -e $_tide_var_list _tide_var_list $_tide_prompt_var
    functions --erase (functions --all | string match --entire --regex '^_tide_')
end
