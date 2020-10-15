if set -q _tide_version
    _tide_count_left_prompt_height

    _tide_detect_os

    _tide_git_prompt_set_vars

    _tide_pwd
end

function _tide_init_install --on-event _tide_init_install
    _set_immutable _tide_color_dark_blue 0087AF
    _set_immutable _tide_color_dark_green 5FAF00
    _set_immutable _tide_color_gold D7AF00
    _set_immutable _tide_color_green 5FD700
    _set_immutable _tide_color_light_blue 00AFFF
    _set_immutable _tide_color_normal (set_color normal)

    _set_immutable _tide_dir "$__fish_config_dir/functions/tide"
    _set_immutable _tide_version 2.4.0

    _set_immutable NVM_DIR $HOME/.nvm
    _set_immutable VIRTUAL_ENV_DISABLE_PROMPT true

    set -U _tide_var_list

    source "$_tide_dir/configure/choices/all/style.fish"
    _load_config 'lean'

    source "$_tide_dir/configure/choices/all/finish.fish"
    _tide_finish

    source "$__fish_config_dir/functions/fish_prompt.fish"

    if status is-interactive
        while true
            switch (read --prompt-str="Configure tide prompt? [Y/n] ")
                case y Y yes Yes ''
                    tide configure
                case n N no No
                    printf '%s' \
                        \n 'Run ' (set_color $fish_color_command) 'tide ' \
                        (set_color $fish_color_param) 'configure ' (set_color normal) 'to customize your prompt.' \n
            end
            break
        end
    end
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    for var in $_tide_var_immutable_list $_tide_var_list
        set -e $var
    end
    set -e _tide_var_immutable_list
    set -e _tide_var_list
end

function _set_immutable -a var_name
    set -U $var_name $argv[2..-1]
    set -Ua _tide_var_immutable_list $var_name
end