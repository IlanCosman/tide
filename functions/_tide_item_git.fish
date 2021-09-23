function _tide_item_git
    set -l location $_tide_location_color(git branch --show-current 2>/dev/null) || return
    # --quiet = don't error if there are no commits
    git rev-parse --quiet --git-dir --is-inside-git-dir --short HEAD |
        read --local --line git_dir is_inside_git_dir sha

    if test -z "$location" # Default to branch, then tag, then sha
        set location '#'$_tide_location_color(git tag --points-at HEAD)[1] # get the first tag
        test -z "$location" && set location '@'$_tide_location_color$sha
    end

    # Operation
    if test -d $git_dir/rebase-merge
        read -f step <$git_dir/rebase-merge/msgnum
        read -f total_steps <$git_dir/rebase-merge/end
        if test -f $git_dir/rebase-merge/interactive
            set -f operation rebase-i
        else
            set -f operation rebase-m
        end
    else if test -d $git_dir/rebase-apply
        read -f step <$git_dir/rebase-apply/next
        read -f total_steps <$git_dir/rebase-apply/last
        if test -f $git_dir/rebase-apply/rebasing
            set -f operation rebase
        else if test -f $git_dir/rebase-apply/applying
            set -f operation am
        else
            set -f operation am/rebase
        end
    else if test -f $git_dir/MERGE_HEAD
        set -f operation merge
    else if test -f $git_dir/CHERRY_PICK_HEAD
        set -f operation cherry-pick
    else if test -f $git_dir/REVERT_HEAD
        set -f operation revert
    else if test -f $git_dir/BISECT_LOG
        set -f operation bisect
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
    set -l data (git $tide_git_set_dir_option stash list 2>/dev/null | count
        string match --regex '^UU' $git_info | count
        string match --regex '^[ADMR].' $git_info | count
        string match --regex '^.[ADMR]' $git_info | count
        string match --regex '^\?\?' $git_info | count)
    test $data[1] != 0 && set -l stash $data[1]
    test $data[2] != 0 && set -l conflicted $data[2]
    test $data[3] != 0 && set -l staged $data[3]
    test $data[4] != 0 && set -l dirty $data[4]
    test $data[5] != 0 && set -l untracked $data[5]

    if set -q operation || set -q conflicted
        set -g tide_git_bg_color $tide_git_bg_color_urgent
    else if set -q staged || set -q dirty || set -q untracked
        set -g tide_git_bg_color $tide_git_bg_color_unstable
    end

    _tide_print_item git $_tide_location_color $tide_git_icon' ' (set_color white; echo -ns $location
        set_color $tide_git_color_operation; echo -ns ' '$operation ' '$step/$total_steps
        set_color $tide_git_color_upstream; echo -ns ' ⇣'$upstream_behind ' ⇡'$upstream_ahead
        set_color $tide_git_color_stash; echo -ns ' *'$stash
        set_color $tide_git_color_conflicted; echo -ns ' ~'$conflicted
        set_color $tide_git_color_staged; echo -ns ' +'$staged
        set_color $tide_git_color_dirty; echo -ns ' !'$dirty
        set_color $tide_git_color_untracked; echo -ns ' ?'$untracked)
end
