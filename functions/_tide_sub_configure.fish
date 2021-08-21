set -g _tide_color_dark_blue 0087AF
set -g _tide_color_dark_green 5FAF00
set -g _tide_color_gold D7AF00
set -g _tide_color_green 5FD700
set -g _tide_color_light_blue 00AFFF

# Create an empty fake function for each item
for func in _fake(functions --all | string match --entire _tide_item)
    function $func
    end
end

for file in (status dirname)/tide/configure/{choices, functions}/**.fish
    source $file
end

function _tide_sub_configure
    if test $COLUMNS -lt 55 -o $LINES -lt 21
        printf '%s\n' 'Terminal size too small; must be at least 55 x 21'
        return 1
    end

    set -g fake_columns $COLUMNS
    test $fake_columns -gt 90 && set fake_columns 90
    set -g fake_lines $LINES

    set -g _tide_selected_option
    _next_choice all/style
end

function _next_choice -a nextChoice
    set -q _tide_selected_option || return 0
    set -l cmd (string split '/' $nextChoice)[2]
    $cmd
end

function _tide_title -a text
    clear
    set_color -o
    string pad --width (math --scale=0 "$fake_columns/2" + (string length $text)/2) $text
    set_color normal
end

function _tide_option -a symbol text
    set -ga _tide_option_list $symbol

    set_color -o
    printf '%s\n' "($symbol) $text"
    set_color normal
end

function _tide_menu
    set -l list_with_slashes (string join '/' $_tide_option_list)

    printf '%s\n' \
        '(r) Restart from the beginning' \
        '(q) Quit and do nothing'\n

    while true
        set_color -o
        read --nchars 1 --prompt-str "Choice [$list_with_slashes/r/q] " input
        set_color normal

        switch $input
            case r
                set -e _tide_option_list
                _next_choice all/style
                break
            case q
                set -e _tide_selected_option # Skip through all the _next_choices
                set -e _tide_option_list
                clear
                break
            case $_tide_option_list
                set -e _tide_option_list
                set -g _tide_selected_option $input
                break
        end
    end
end

function _tide_display_prompt -a var_name var_value
    test -n "$var_name" && set -g $var_name $var_value
    _fake_tide_prompt
    printf '\n\n'
end

function _set_all_items_bg_color -a color
    for var in (set --names | string match --regex "fake_.*_bg_color.*" | string match --invert --entire character)
        set $var $color
    end
end
