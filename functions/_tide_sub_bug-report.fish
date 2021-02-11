function _tide_sub_bug-report
    argparse 'c/clean' 'v/verbose' -- $argv

    if set -q _flag_clean
        HOME=(mktemp -d) fish --init-command "curl --silent \
        https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
        source && fisher install ilancosman/tide"
    else if set -q _flag_verbose
        set | string match --regex "^_?tide.*"
    else
        fish --version
        tide --version
        printf '%s\n' $TERM
    end
end