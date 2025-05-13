function _tide_init_install --on-event _tide_init_install
    set -U VIRTUAL_ENV_DISABLE_PROMPT true

    source (functions --details _tide_sub_configure)
    _load_config lean
    _tide_finish

    if status is-interactive
        tide bug-report --check || sleep 4

        if contains plttn/tide (string lower $_fisher_plugins)
            set_color bryellow
            echo "plttn/tide is a development branch. Please install from a release tag:"
            _tide_fish_colorize "fisher install plttn/tide@v6"
            sleep 3
        end

        switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
            case y ye yes ''
                tide configure
            case '*'
                echo -s \n 'Run ' (_tide_fish_colorize "tide configure") ' to customize your prompt.'
        end
    end
end

function _tide_init_update --on-event _tide_init_update
    # Warn users who install from main branch
    if contains plttn/tide (string lower $_fisher_plugins)
        set_color bryellow
        echo "plttn/tide is a development branch. Please install from a release tag:"
        _tide_fish_colorize "fisher install plttn/tide@v6"
        sleep 3
    end

    # Set (disable) the new jobs variable
    set -q tide_jobs_number_threshold || set -U tide_jobs_number_threshold 1000
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    set -e VIRTUAL_ENV_DISABLE_PROMPT
    set -e (set -U --names | string match --entire -r '^_?tide')
    functions --erase (functions --all | string match --entire -r '^_?tide')
end
