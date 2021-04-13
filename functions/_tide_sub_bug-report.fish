function _tide_sub_bug-report
    argparse c/clean v/verbose -- $argv

    if set -q _flag_clean
        HOME=(mktemp -d) fish --init-command "curl --silent \
        https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
        source && fisher install ilancosman/tide"
    else if set -q _flag_verbose
        set --long | string match --regex "^_?tide.*" | # Get only tide variables
            string match --regex --invert "^_tide_.*_prompt_display_.*" | # Remove _tide_left_prompt_display_5770 etc
            string match --regex --invert "^_tide_var_list.*" # Remove _tide_var_list
    else
        set -l fishVersion (fish --version | string match --regex "fish, version (\d\.\d\.\d)")[2]
        _tide_check_version Fish fish-shell/fish-shell "(\d\.\d\.\d)" $fishVersion || return

        set -l tideVersion (tide --version | string match --regex "tide, version (\d\.\d\.\d)")[2]
        _tide_check_version Tide IlanCosman/tide "v(\d\.\d\.\d)" $tideVersion || return

        # Check that omf is not installed
        not functions --query omf
        _tide_check_condition \
            "Tide does not work with oh-my-fish installed." \
            "Please uninstall it before submitting a bug report." || return

        read --local --prompt-str "What operating system are you using? (e.g Ubuntu 20.04): " os
        read --local --prompt-str "What terminal emulator are you using? (e.g Kitty): " terminalEmulator

        printf '%b\n' "\nPlease copy the following information into the issue:\n" \
            "fish version: $fishVersion" \
            "tide version: $tideVersion" \
            "term: $TERM" \
            "os: $os" \
            "terminal emulator: $terminalEmulator"
    end
end

function _tide_check_version -a programName repoName regexToGetVersion currentVersion
    curl --silent https://github.com/$repoName/releases/latest |
        string match --regex ".*$repoName/releases/tag/$regexToGetVersion.*" |
        read --local --line __ latestVersion

    string match --quiet --regex "^$latestVersion" "$currentVersion"
    _tide_check_condition \
        "Your $programName version is out of date." \
        "The latest is $latestVersion. You have $currentVersion." \
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
