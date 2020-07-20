function _tide_sub_configure
    if test $COLUMNS -lt 55 || test $LINES -lt 21
        printf '%s\n' 'Terminal size too small; must be at least 55 x 21'
        return 1
    end

    set -g fake_columns $COLUMNS
    if test $fake_columns -gt 90
        set -g fake_columns 90
    end
    set -g fake_lines $LINES

    for fn in $_tide_dir/configure/functions/*
        source "$fn"
    end
    for promptItem in $_tide_dir/configure/prompt_items/*
        source "$promptItem"
    end

    _tide_begin
end

function _tide_begin
    _next_choice 'all/style'
end

function _next_choice -a nextChoice
    source "$_tide_dir/configure/choices/$nextChoice.fish"
    set -l cmd (string split '/' $nextChoice)[2]
    $cmd
end

function _tide_menu
    set -l bold (set_color -o)
    set -l norm (set_color normal)

    set -l listWithSlashes (string join '/' $_tide_option_list)

    while true
        read -P $bold"Choice [$listWithSlashes] "$norm input

        if contains $input $_tide_option_list
            printf '%s\n' $input
            set -e _tide_option_list
            break
        end
    end
end

function _tide_title -a text
    set -l midCols (math --scale=0 $fake_columns/2)
    set -l midTitle (math --scale=0 (string length $text)/2)

    clear

    _tide_cursor_right (math $midCols-$midTitle)
    set_color -o
    printf '%s\n' $text
    set_color normal
end

function _tide_option -a symbol text
    set -ga _tide_option_list $symbol

    set_color -o
    printf '%s\n' "($symbol) $text"
    set_color normal
end

function _tide_display_prompt -a var_name var_value
    if test -n "$var_name"
        set -g $var_name $var_value
    end
    fake_prompt
    printf '\n\n'
end

function _tide_display_restart_and_tide_quit
    printf '%s\n' '(r)  Restart from the beginning'
    printf '%s\n' '(q)  Quit and do nothing'
    printf '%s\n' ''

    set -ga _tide_option_list r q
end

function _tide_quit --on-signal INT
    clear
    source "$__fish_config_dir/functions/fish_prompt.fish"
    source "$__fish_config_dir/functions/_tide_left_prompt.fish"
    source "$__fish_config_dir/functions/_tide_right_prompt.fish"
end