function lean_install
    echo "Installing lean theme..."

    # -----------------Download Functions-----------------
    set -l tempDir "/tmp/lean_theme"

    # Clone repository into $tempDir
    if test -e $tempDir
        rm -rf $tempDir
    end
    git clone -q --depth=1 https://github.com/IlanCosman/lean.git $tempDir

    # Remove unnecessary files
    rm "$tempDir/install.fish"
    rm "$tempDir/README.md"
    rm -rf "$tempDir/.git/"

    # Copy directory contents into $__fish_config_dir and cleanup
    cp -rf "$tempDir/." $__fish_config_dir
    rm -rf $tempDir

    # ----------------Set Theme Variables----------------
    # --------------Colors--------------
    set -U lean_color_green 5FD700
    set -U lean_color_light_blue 00AFFF
    set -U lean_color_dark_blue 0087AF
    set -U lean_color_gold D7AF00
    # --------------Timer--------------
    set -U lean_timer_color 87875F
    set -U lean_timer_decimals 0
    set -U lean_timer_duration 3
    # ---------------SSH---------------
    set -U lean_ssh_color D7AF87
    # ---------------Pwd---------------
    set -U fish_prompt_pwd_dir_length 0
    set -U lean_shorten_pwd_margin 5
    # ------------Git prompt------------
    set -U __fish_git_prompt_show_informative_status true
    set -U __fish_git_prompt_showstashstate true
    # -------Symbols-------
    set -U __fish_git_prompt_char_stateseparator ""
    set -U __fish_git_prompt_char_cleanstate ""
    set -U __fish_git_prompt_char_upstream_ahead " ⇡"
    set -U __fish_git_prompt_char_upstream_behind " ⇣"
    set -U __fish_git_prompt_char_stagedstate " +"
    set -U __fish_git_prompt_char_dirtystate ' !'
    set -U __fish_git_prompt_char_untrackedfiles ' ?'
    set -U __fish_git_prompt_char_stashstate " *"
    # --------Colors--------
    set -U __fish_git_prompt_color_branch $lean_color_green
    set -U __fish_git_prompt_color_upstream $lean_color_green
    set -U __fish_git_prompt_color_stagedstate $lean_color_gold
    set -U __fish_git_prompt_color_dirtystate $lean_color_gold
    set -U __fish_git_prompt_color_untrackedfiles $lean_color_light_blue
    set -U __fish_git_prompt_color_stashstate $lean_color_green

    source "$__fish_config_dir/functions/fish_prompt.fish"

    set_color $lean_color_green
    echo "Lean theme installed!"
    set_color $fish_color_normal

    if _user_confirm_defaultYes "Configure prompt?"
        lean_wizard
    else
        echo -e "\n""Run lean_wizard to configure your prompt."
    end
end

function _user_confirm_defaultYes --argument-names question
    while true
        read -P "$question [Y/n] " input

        switch $input
            case y Y yes Yes
                return 0
            case n N no No
                return 1
            case ''
                return 0
        end
    end
end