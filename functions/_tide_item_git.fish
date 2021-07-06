function _tide_item_git
    set -l location_color (set_color $tide_git_color_branch || echo)
    set -l location $location_color(git branch --show-current 2>/dev/null) || return
    # --quiet = don't error if there are no commits
    git rev-parse --quiet --git-dir --is-inside-git-dir --short HEAD |
        read --local --line git_dir is_inside_git_dir sha

    if test -z "$location" # Default to branch, then tag, then sha
        set location '#'$location_color(git tag --points-at HEAD)[1] # get the first tag
        test -z "$location" && set location '@'$location_color$sha
    end

    # Operation
    if test -d $git_dir/rebase-merge
        read tide_git_step <$git_dir/rebase-merge/msgnum
        read tide_git_total_steps <$git_dir/rebase-merge/end
        if test -f $git_dir/rebase-merge/interactive
            set tide_git_operation rebase-i
        else
            set tide_git_operation rebase-m
        end
    else if test -d $git_dir/rebase-apply
        read tide_git_step <$git_dir/rebase-apply/next
        read tide_git_total_steps <$git_dir/rebase-apply/last
        if test -f $git_dir/rebase-apply/rebasing
            set tide_git_operation rebase
        else if test -f $git_dir/rebase-apply/applying
            set tide_git_operation am
        else
            set tide_git_operation am/rebase
        end
    else if test -f $git_dir/MERGE_HEAD
        set tide_git_operation merge
    else if test -f $git_dir/CHERRY_PICK_HEAD
        set tide_git_operation cherry-pick
    else if test -f $git_dir/REVERT_HEAD
        set tide_git_operation revert
    else if test -f $git_dir/BISECT_LOG
        set tide_git_operation bisect
    end

    # Upstream behind/ahead. Suppress errors in case there is no upstream
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null |
        read --local --delimiter=\t upstream_behind upstream_ahead
    test "$upstream_behind" = 0 && set -e upstream_behind
    test "$upstream_ahead" = 0 && set -e upstream_ahead

    # Git status/stash
    test "$is_inside_git_dir" = true && set -l tide_git_set_dir_option -C $git_dir/..
    # Suppress errors in case we are in a bare repo
    set -l git_info (git $tide_git_set_dir_option --no-optional-locks status --porcelain 2>/dev/null)
    set -l stash (git $tide_git_set_dir_option stash list 2>/dev/null | count) || set -e stash
    set -l conflicted (string match --regex '^UU' $git_info | count) || set -e conflicted
    set -l staged (string match --regex '^[ADMR].' $git_info | count) || set -e staged
    set -l dirty (string match --regex '^.[ADMR]' $git_info | count) || set -e dirty
    set -l untracked (string match --regex '^\?\?' $git_info | count) || set -e untracked

    if set -q tide_git_operation || set -q conflicted
        set -g tide_git_bg_color $tide_git_bg_color_urgent
    else if set -q staged || set -q dirty || set -q untracked
        set -g tide_git_bg_color $tide_git_bg_color_unstable
    end

    _tide_print_item git $location_color $tide_git_icon' ' (set_color white; printf %s $location
        set_color $tide_git_color_operation; printf %s ' '$tide_git_operation ' '$tide_git_step/$tide_git_total_steps
        set_color $tide_git_color_upstream; printf %s ' ⇣'$upstream_behind ' ⇡'$upstream_ahead
        set_color $tide_git_color_stash; printf %s ' *'$stash
        set_color $tide_git_color_conflicted; printf %s ' ~'$conflicted
        set_color $tide_git_color_staged; printf %s ' +'$staged
        set_color $tide_git_color_dirty; printf %s ' !'$dirty
        set_color $tide_git_color_untracked; printf %s ' ?'$untracked)
end
