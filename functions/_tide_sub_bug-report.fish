function _tide_sub_bug-report
    argparse c/clean v/verbose check -- $argv

    set -l fish_path (status fish-path)

    if set -q _flag_clean
        HOME=(mktemp -d) $fish_path --init-command "curl --silent \
        https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
        source && fisher install ilancosman/tide@v6"
    else if set -q _flag_verbose
        set --long | string match -r "^_?tide.*" | # Get only tide variables
            string match -r --invert "^_tide_prompt_var.*" # Remove _tide_prompt_var
    else
        $fish_path --version | string match -qr "fish, version (?<fish_version>.*)"
        _tide_check_version Fish fish-shell/fish-shell "(?<v>[\d.]+)" $fish_version || return

        tide --version | string match -qr "tide, version (?<tide_version>.*)"
        _tide_check_version Tide IlanCosman/tide "v(?<v>[\d.]+)" $tide_version || return

        if command --query git
            test (path sort (git --version) "git version 2.22.0")[1] = "git version 2.22.0"
            _tide_check_condition \
                "Your git version is too old." \
                "Tide requires at least version 2.22." \
                "Please update before submitting a bug report." || return
        end

        # Check that omf is not installed
        not functions --query omf
        _tide_check_condition \
            "Tide does not work with oh-my-fish installed." \
            "Please uninstall it before submitting a bug report." || return

        if not set -q _flag_check
            $fish_path -ic "time $fish_path -c exit" 2>|
                string match -rg "Executed in(.*)fish" |
                string trim | read -l fish_startup_time

            read -l --prompt-str "What operating system are you using? (e.g Ubuntu 20.04): " os
            read -l --prompt-str "What terminal emulator are you using? (e.g Kitty): " terminal_emulator

            printf '%b\n' "\nPlease copy the following information into the issue:\n" \
                "fish version: $fish_version" \
                "tide version: $tide_version" \
                "term: $TERM" \
                "os: $os" \
                "terminal emulator: $terminal_emulator" \
                "fish startup: $fish_startup_time" \
                "fisher plugins: $_fisher_plugins"
        end
    end
end

function _tide_check_version -a program_name repo_name regex_to_get_v installed_version
    curl -sL https://github.com/$repo_name/releases/latest |
        string match -qr "https://github.com/$repo_name/releases/tag/$regex_to_get_v"

    string match -qr "^$v" "$installed_version" # Allow git versions, e.g 3.3.1-701-gceade1629
    _tide_check_condition \
        "Your $program_name version is out of date." \
        "The latest is $v. You have $installed_version." \
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
