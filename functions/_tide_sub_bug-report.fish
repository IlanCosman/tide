function _tide_sub_bug-report
    argparse c/clean v/verbose -- $argv

    if set -q _flag_clean
        HOME=(mktemp -d) fish --init-command "curl --silent \
        https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
        source && fisher install ilancosman/tide"
    else if set -q _flag_verbose
        printf '%s\n' $TERM

        set --long | string match --regex "^_?tide.*" | # Get only tide variables
            string match --regex --invert "^_tide_.*_prompt_display_.*" | # Remove _tide_left_prompt_display_5770 etc
            string match --regex --invert "^_tide_var_list.*" # Remove _tide_var_list
    else
        set -l currentFishVersion (fish --version | string match --regex "fish, version (\d\.\d\.\d)")[2]
        _tide_check_version Fish fish-shell/fish-shell "(\d\.\d\.\d)" $currentFishVersion || return

        set -l currentTideVersion (tide --version | string match --regex "tide, version (\d\.\d\.\d)")[2]
        _tide_check_version Tide IlanCosman/tide "v(\d\.\d\.\d)" $currentTideVersion || return
    end
end

function _tide_check_version -a programName repoName regexToGetVersion currentVersion
    printf '%s' "Using latest version of $programName... "

    curl --silent https://github.com/$repoName/releases/latest |
        string match --regex ".*$repoName/releases/tag/$regexToGetVersion.*" |
        read --local --line __ latestVersion

    if string match --quiet --regex "^$latestVersion" "$currentVersion"
        set_color brgreen
        printf '%s\n' $tide_status_success_icon
        set_color normal
        return 0
    else
        set_color red
        printf '%s\n' $tide_status_failure_icon \
            "Your $programName version is out of date." \
            "The latest is $latestVersion. You have $currentVersion." \
            "Please update before submitting a bug report."
        set_color normal
        return 1
    end
end
