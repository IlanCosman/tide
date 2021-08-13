function _tide_sub_bug-report
    argparse c/clean v/verbose -- $argv

    if set -q _flag_clean
        HOME=(mktemp -d) fish --init-command "curl --silent \
        https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
        source && fisher install ilancosman/tide@v5"
    else if set -q _flag_verbose
        set --long | string match --regex "^_?tide.*" | # Get only tide variables
            string match --regex --invert "^_tide_prompt_var.*" | # Remove _tide_prompt_var
            string match --regex --invert "^_tide_prompt_data.*" | # Remove _tide_prompt_data
            string match --regex --invert "^_tide_var_list.*" # Remove _tide_var_list
    else
        set -l fish_version (fish --version | string match --regex "fish, version (\d\.\d\.\d)")[2]
        _tide_check_version Fish fish-shell/fish-shell "(\d\.\d\.\d)" $fish_version || return

        set -l tide_version (tide --version | string match --regex "tide, version (\d\.\d\.\d)")[2]
        _tide_check_version Tide IlanCosman/tide "v(\d\.\d\.\d)" $tide_version || return

        test (git --version | string match --regex "git version ([\d\.]*)" | string replace --all '.' '')[2] -gt 2220
        _tide_check_condition \
            "Your git version is too old." \
            "Tide requires at least version 2.22." \
            "Please update before submitting a bug report." || return

        # Check that omf is not installed
        not functions --query omf
        _tide_check_condition \
            "Tide does not work with oh-my-fish installed." \
            "Please uninstall it before submitting a bug report." || return

        read --local --prompt-str "What operating system are you using? (e.g Ubuntu 20.04): " os
        read --local --prompt-str "What terminal emulator are you using? (e.g Kitty): " terminal_emulator

        printf '%b\n' "\nPlease copy the following information into the issue:\n" \
            "fish version: $fish_version" \
            "tide version: $tide_version" \
            "term: $TERM" \
            "os: $os" \
            "terminal emulator: $terminal_emulator"
    end
end

function _tide_check_version -a program_name repo_name regex_to_get_version current_version
    curl --silent https://github.com/$repo_name/releases/latest |
        string match --regex ".*$repo_name/releases/tag/$regex_to_get_version.*" |
        read --local --line __ latestVersion

    string match --quiet --regex "^$latestVersion" "$current_version"
    _tide_check_condition \
        "Your $program_name version is out of date." \
        "The latest is $latestVersion. You have $current_version." \
        "Please update before submitting a bug report."
end

function _tide_check_condition
    if test "$status" != 0
        set_color red
        printf '%s\n' $argv
        set_color normal
        return 1
    end
    return 0
end
