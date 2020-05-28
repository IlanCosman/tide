function _tide_item_git_prompt
    if test -n "$git_dir"
        fish_git_prompt '%s '
    end
end