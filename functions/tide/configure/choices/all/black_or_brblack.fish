function black_or_brblack
    _tide_title 'Which of these squares do you see?'

    set -l list black brblack

    for arg in $list
        set_color -b $arg
        string repeat --no-newline --count 7 ' '
        set_color normal

        string repeat --no-newline --count 2 ' '
    end
    echo
    for arg in $list
        set_color -b $arg
        string repeat --no-newline --count 3 ' '
        set_color --bold
        echo -ns (contains --index $arg $list)
        string repeat --no-newline --count 3 ' '
        set_color normal

        string repeat --no-newline --count 2 ' '
    end
    echo
    for arg in $list
        set_color -b $arg
        string repeat --no-newline --count 7 ' '
        set_color normal

        string repeat --no-newline --count 2 ' '
    end

    echo \n

    _tide_option 1 "I only see the square around 1"
    echo

    _tide_option 2 "I only see the square around 2"
    echo

    _tide_option 3 "I see both squares"
    echo

    _tide_menu
    switch $_tide_selected_option
        case 1
            _load_config "$_tide_configure_style"
            set -e _tide_16color
            switch $_tide_configure_style
                case lean rainbow
                    _next_choice all/show_time
                case classic
                    _next_choice classic/classic_prompt_color
            end
    end
    _next_choice all/show_time
end
