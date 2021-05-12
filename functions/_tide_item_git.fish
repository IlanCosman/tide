function _tide_item_git
    set -l location (git branch --show-current 2>/dev/null) || return
    # --quiet=don't complain if there are no commits
    git rev-parse --quiet --git-dir --is-inside-git-dir --short HEAD |
        read --local --line git_dir is_inside_git_dir sha
    # Default to branch, then tag, then sha
    if test -z "$location" # Default to branch
        set location (git tag --points-at HEAD)[1] # only get the first tag
        set location_character '#'
        if test -z "$location"
            set location $sha
            set location_character '@'
        end
    end

    # Operation
    set -l operation
    set -l step
    set -l total_steps

    if test -d $git_dir/rebase-merge
        read step <$git_dir/rebase-merge/msgnum
        read total_steps <$git_dir/rebase-merge/end
        if test -f $git_dir/rebase-merge/interactive
            set operation rebase-i
        else
            set operation rebase-m
        end
    else if test -d $git_dir/rebase-apply
        read step <$git_dir/rebase-apply/next
        read total_steps <$git_dir/rebase-apply/last
        if test -f $git_dir/rebase-apply/rebasing
            set operation rebase
        else if test -f $git_dir/rebase-apply/applying
            set operation am
        else
            set operation am/rebase
        end
    else if test -f $git_dir/MERGE_HEAD
        set operation merge
    else if test -f $git_dir/CHERRY_PICK_HEAD
        set operation cherry-pick
    else if test -f $git_dir/REVERT_HEAD
        set operation revert
    else if test -f $git_dir/BISECT_LOG
        set operation bisect
    end

    # Upstream behind/ahead
    # Suppress errors in case there is no upstream
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null |
        read --local --delimiter=\t upstream_behind upstream_ahead
    test "$upstream_behind" = 0 && set -e upstream_behind
    test "$upstream_ahead" = 0 && set -e upstream_ahead

    # Git status/stash
    test "$is_inside_git_dir" = true && set -l git_set_dir_option -C $git_dir/..

    # Suppress errors in case we are in a bare repo
    set -l git_info (git $git_set_dir_option --no-optional-locks status --porcelain 2>/dev/null)
    set -l stash (git $git_set_dir_option stash list 2>/dev/null | count) || set -e stash
    set -l conflicted (string match --regex '^UU' $git_info | count) || set -e conflicted
    set -l staged (string match --regex '^[ADMR].' $git_info | count) || set -e staged
    set -l dirty (string match --regex '^.[ADMR]' $git_info | count) || set -e dirty
    set -l untracked (string match --regex '^\?\?' $git_info | count) || set -e untracked

    # Print the information
    _tide_print_item git \
        $location_character (set_color $tide_git_branch_color) $location \
        (set_color $tide_git_operation_color) ' '$operation ' '$step/$total_steps \
        (set_color $tide_git_upstream_color) ' ⇣'$upstream_behind ' ⇡'$upstream_ahead \
        (set_color $tide_git_stash_color) ' *'$stash \
        (set_color $tide_git_conflicted_color) ' ~'$conflicted \
        (set_color $tide_git_staged_color) ' +'$staged \
        (set_color $tide_git_dirty_color) ' !'$dirty \
        (set_color $tide_git_untracked_color) ' ?'$untracked
end
