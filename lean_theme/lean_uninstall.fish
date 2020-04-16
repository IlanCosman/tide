function lean_uninstall
    if user_ask "Unininstall lean theme?" y/N
        echo "Uninstalling lean theme..."

        # ------------------Remove Functions------------------
        rm "$__fish_config_dir/conf.d/lean_source.fish"
        rm -r "$__fish_config_dir/lean_theme/"

        # ---------------Erase Theme Variables---------------
        # --------------Colors--------------
        set vars $vars lean_green lean_light_blue lean_dark_blue lean_gold
        # ---------------Pwd---------------
        set vars $vars fish_prompt_pwd_dir_length lean_shorten_pwd_margin
        # ------------Git prompt------------
        set vars $vars __fish_git_prompt_show_informative_status __fish_git_prompt_showstashstate
        # -------Symbols-------
        set vars $vars __fish_git_prompt_char_stateseparator __fish_git_prompt_char_cleanstate
        set vars $vars __fish_git_prompt_char_upstream_ahead __fish_git_prompt_char_upstream_behind
        set vars $vars __fish_git_prompt_char_stagedstate __fish_git_prompt_char_dirtystate
        set vars $vars __fish_git_prompt_char_untrackedfiles __fish_git_prompt_char_stashstate
        # --------Colors--------
        set vars $vars __fish_git_prompt_color_branch __fish_git_prompt_color_upstream
        set vars $vars __fish_git_prompt_color_stagedstate __fish_git_prompt_color_dirtystate
        set vars $vars __fish_git_prompt_color_untrackedfiles __fish_git_prompt_color_stashstate

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