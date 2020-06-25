function _tide_item_git_prompt
    if test -n "$_tide_git_dir"
        fish_git_prompt '%s'
    end
end