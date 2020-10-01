function tide_install
    if not command -q git
        printf '%s\n' 'Git must be available to install Tide.'
        return 1
    end

    set -l options l/local u/unattended
    argparse $options -- $argv

    # Pass through options to _tide_actual_install
    for option in $options
        set -l longFormOption (string split '/' $option)[2]
        if set -q _flag_$longFormOption
            set -a flags "--$longFormOption"
        end
    end
    
    set -l location $argv[-1]
    if test -z "$location"
        set location 'main'
    end

    if set -q _flag_local
        source "$location/tools/_tide_actual_install.fish"
    else
        curl --silent "https://raw.githubusercontent.com/IlanCosman/tide/$location/tools/_tide_actual_install.fish" | source
    end

    _tide_actual_install $flags $argv
end