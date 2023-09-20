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
    set -l choices (path basename (status dirname)/tide/configure/choices/**.fish | path change-extension '')
    argparse auto $choices= -- $argv

    for var in (set -l --names | string match -e _flag)
        set -x $var $$var
    end

    if set -q _flag_auto
        set -fx _flag_finish 'Overwrite your current tide config'
    else if test $COLUMNS -lt 55 -o $LINES -lt 21
        echo 'Terminal size too small; must be at least 55 x 21'
        return 1
    end

    _tide_detect_os | read -g --line os_branding_icon os_branding_color os_branding_bg_color

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
    set -q _flag_auto && return

    command -q clear && clear
    set_color -o
    string pad --width (math --scale=0 "$fake_columns/2" + (string length $text)/2) $text
    set_color normal

    set -g _tide_configure_first_option_after_title
end

function _tide_option -a symbol text
    set -ga _tide_symbol_list $symbol
    set -ga _tide_option_list $text

    if not set -q _flag_auto
        set -g _tide_configure_first_prompt_after_option

        set_color -o
        set -e _tide_configure_first_option_after_title || echo
        echo "($symbol) $text"
        set_color normal
    end
end

function _tide_menu -a func
    if set -q _flag_auto
        set -l flag_var_name _flag_$func
        set -g _tide_selected_option $$flag_var_name

        if test -z "$_tide_selected_option"
            echo "Missing input for choice '$func'"
            _tide_exit_configure
        else if not contains $_tide_selected_option $_tide_option_list
            echo "Invalid input '$_tide_selected_option' for choice '$func'"
            _tide_exit_configure
        else
            set -e _tide_symbol_list
            set -e _tide_option_list
        end
        return
    end

    argparse no-restart -- $argv # Add no-restart option for first menu

    echo
    if not set -q _flag_no_restart
        set -f r r
        echo '(r) Restart from the beginning'
    end
    echo '(q) Quit and do nothing'\n

    while read --nchars 1 --prompt-str \
            "$(set_color -o)Choice [$(string join '/' $_tide_symbol_list $r q)] $(set_color normal)" input
        switch $input
            case r
                set -q _flag_no_restart && continue
                set -e _tide_symbol_list
                set -e _tide_option_list
                _next_choice all/style
                break
            case q
                _tide_exit_configure
                set -e _tide_symbol_list
                set -e _tide_option_list
                command -q clear && clear
                break
            case $_tide_symbol_list
                set -g _tide_selected_option $_tide_option_list[(contains -i $input $_tide_symbol_list)]
                test "$func" != finish &&
                    set -a _tide_configure_current_options --$func=(string escape $_tide_selected_option)
                set -e _tide_symbol_list
                set -e _tide_option_list
                break
        end
    end
end

function _tide_display_prompt
    set -q _flag_auto && return

    _fake_tide_cache_variables
    set -l prompt (_fake_tide_prompt)

    set -l bottom_left_prompt_string_length (string length --visible $prompt[-1])
    set -l right_prompt_string (string pad --width (math $fake_columns-$bottom_left_prompt_string_length) $prompt[1])
    set -l prompt[-1] "$prompt[-1]$right_prompt_string"

    if set -q _configure_transient
        if contains newline $fake_tide_left_prompt_items
            string unescape $prompt[3..]
        else
            _fake_tide_item_character
            echo
        end
    else
        if not set -q _tide_configure_first_prompt_after_option
            test "$fake_tide_prompt_add_newline_before" = true && echo
        end
        string unescape $prompt[2..]
    end

    set -e _tide_configure_first_prompt_after_option
    set_color normal
end

function _tide_exit_configure
    set -e _tide_selected_option # Skip through all switch and _next_choice
end
