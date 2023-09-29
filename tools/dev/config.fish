if status is-interactive
    starship init fish | source

    functions --copy fish_prompt starship_fish_prompt

    function fish_prompt
        sleep $sleep_time
        starship_fish_prompt
    end

    set -gx sleep_time 0

    function toggle_sleep_time
        if test "$sleep_time" = 0
            set -g sleep_time 3
        else
            set -g sleep_time 0
        end
    end

    bind \cS toggle_sleep_time

    function history_merge
        history merge
    end

    bind \cH history_merge
end
