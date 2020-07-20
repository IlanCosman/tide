function _tide_git_prompt_set_vars --on-variable tide_git_prompt_bg_color
    switch $tide_git_prompt_bg_color
        case '' 'normal'
            set color ''
        case '*'
            set color (set_color -b $tide_git_prompt_bg_color)
    end

    for var in (set --names | string match --regex "__fish_git_prompt_char_.*")
        set -g _$var $color$$var
    end
end