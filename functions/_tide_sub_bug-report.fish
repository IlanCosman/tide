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
        fish --version
        tide --version
        printf '%s\n' $TERM
    end
end
