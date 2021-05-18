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

    _tide_menu
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
    string replace --regex '^' 'set -g fake_' <(status dirname)/../../configs/$name.fish | source
end
