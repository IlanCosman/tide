function lean_uninstall
    if _user_confirm_defaultNo "Unininstall lean theme?"
        echo "Uninstalling lean theme..."

        # ------------------Remove Files------------------
        rm "$__fish_config_dir/functions/fish_prompt.fish"
        rm "$__fish_config_dir/functions/lean"*
        rm -r "$__fish_config_dir/lean_theme"

        # ---------------Erase Theme Variables---------------
        # --------------Prompt--------------
        set -l vars $vars lean_prompt_connection lean_prompt_connection_color
        # --------------Colors--------------
        set -l vars $vars lean_color_green lean_color_light_blue lean_color_dark_blue lean_color_gold
        # --------------Timer--------------
        set -l vars $vars lean_timer_color lean_timer_decimals lean_timer_duration
        # ---------------Pwd---------------
        set -l vars $vars fish_prompt_pwd_dir_length lean_shorten_pwd_margin
        # ------------Git prompt------------
        set -l vars $vars __fish_git_prompt_show_informative_status __fish_git_prompt_showstashstate
        # -------Symbols-------
        set -l vars $vars __fish_git_prompt_char_stateseparator __fish_git_prompt_char_cleanstate
        set -l vars $vars __fish_git_prompt_char_upstream_ahead __fish_git_prompt_char_upstream_behind
        set -l vars $vars __fish_git_prompt_char_stagedstate __fish_git_prompt_char_dirtystate
        set -l vars $vars __fish_git_prompt_char_untrackedfiles __fish_git_prompt_char_stashstate
        # --------Colors--------
        set -l vars $vars __fish_git_prompt_color_branch __fish_git_prompt_color_upstream
        set -l vars $vars __fish_git_prompt_color_stagedstate __fish_git_prompt_color_dirtystate
        set -l vars $vars __fish_git_prompt_color_untrackedfiles __fish_git_prompt_color_stashstate

        for var in $vars
            set -e $var
        end

        echo "Lean theme uninstalled. Exiting fish."
        sleep 1
        exit
    else
        echo "Aborted uninstall."
    end
end

function _user_confirm_defaultNo --argument-names question
    while true
        read -P "$question [y/N] " input

        switch $input
            case y Y yes Yes
                return 0
            case n N no No
                return 1
            case ''
                return 1
        end
    end
end