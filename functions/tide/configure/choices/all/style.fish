function style
    _tide_title 'Prompt Style'

    _tide_option 1 Lean
    _load_config lean
    _tide_display_prompt

    _tide_option 2 Classic
    _load_config classic
    _tide_display_prompt

    _tide_option 3 Rainbow
    _load_config rainbow
    _tide_display_prompt

    _tide_style_menu
    switch $_tide_selected_option
        case 1
            _load_config lean
            set -g _tide_configure_style lean
        case 2
            _load_config classic
            set -g _tide_configure_style classic
        case 3
            _load_config rainbow
            set -g _tide_configure_style rainbow
    end
    _next_choice all/prompt_colors
end

function _load_config -a name
    string replace -r '^' 'set -g fake_' <(status dirname)/../../configs/$name.fish | source
end

function _tide_style_menu # Exactly like _tide_menu except that it doesn't have (r) option
    set -l list_with_slashes (string join '/' $_tide_option_list)

    echo '(q) Quit and do nothing'\n

    while true
        set_color -o
        read --nchars 1 --prompt-str "Choice [$list_with_slashes/q] " input
        set_color normal

        switch $input
            case q
                set -e _tide_selected_option # Skip through all the _next_choices
                set -e _tide_option_list
                command -q clear && clear
                break
            case $_tide_option_list
                set -e _tide_option_list
                set -g _tide_selected_option $input
                break
        end
    end
end
