function _tide_git_prompt_set_vars -v tide_git_prompt_bg_color
    if test "$tide_git_prompt_bg_color" = 'normal'
        set color ''
    else
        set color (set_color -b $tide_git_prompt_bg_color)
    end

    set -a vars __fish_git_prompt_char_{cleanstate, dirtystate, invalidstate, stagedstate, stashstate}
    set -a vars __fish_git_prompt_char_{stateseparator, untrackedfiles}
    set -a vars __fish_git_prompt_char_{upstream_ahead, upstream_behind, upstream_diverged, upstream_equal, upstream_prefix}

    for var in $vars
        set -g _$var $color$$var
    end
end