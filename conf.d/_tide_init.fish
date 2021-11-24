function _tide_init_install --on-event _tide_init_install
    set -U VIRTUAL_ENV_DISABLE_PROMPT true

    source (functions --details _tide_sub_configure)
    _load_config lean
    _tide_finish

    status is-interactive && switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
        case y ye yes ''
            tide configure
        case '*'
            echo -ns \n 'Run ' (echo -ns "tide configure" | fish_indent --ansi) ' to customize your prompt.' \n
    end
end

function _tide_init_update --on-event _tide_init_update
    # Warn users who install from main branch
    if contains ilancosman/tide (string lower $_fisher_plugins)
        set_color bryellow
        echo "ilancosman/tide is a development branch. Please install from a release tag:"
        echo -ns "fisher install ilancosman/tide@v5" | fish_indent --ansi
        sleep 3
    end

    # v5 introduced tide_prompt_min_cols. Only proceed if older than v5
    set --query tide_prompt_min_cols && return

    # Save old vars to tmp file
    set -l tmp (mktemp -t tide_old_config.XXXXX)
    tide bug-report --verbose >$tmp

    # Delete old vars
    set -e (set -U --names | string match --entire -r '^_?tide_')

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
    set -e VIRTUAL_ENV_DISABLE_PROMPT
    set -e (set -U --names | string match --entire -r '^_?tide_')
    functions --erase (functions --all | string match --entire -r '^_tide_')
end
