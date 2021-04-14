function _tide_item_git
    # Branch or SHA
    set -l branch (git branch --show-current 2>/dev/null) || return
    # --quiet=don't complain if there are no commits
    git rev-parse --quiet --git-dir --is-inside-git-dir --short HEAD |
        read --local --line gitDir isInsideGitDir location
    test -n "$branch" && set location $branch # location is SHA if branch is empty

    # Operation
    set -l operation
    set -l step
    set -l totalSteps

    if test -d $gitDir/rebase-merge
        read step <$gitDir/rebase-merge/msgnum
        read totalSteps <$gitDir/rebase-merge/end
        if test -f $gitDir/rebase-merge/interactive
            set operation rebase-i
        else
            set operation rebase-m
        end
    else if test -d $gitDir/rebase-apply
        read step <$gitDir/rebase-apply/next
        read totalSteps <$gitDir/rebase-apply/last
        if test -f $gitDir/rebase-apply/rebasing
            set operation rebase
        else if test -f $gitDir/rebase-apply/applying
            set operation am
        else
            set operation am/rebase
        end
    else if test -f $gitDir/MERGE_HEAD
        set operation merge
    else if test -f $gitDir/CHERRY_PICK_HEAD
        set operation cherry-pick
    else if test -f $gitDir/REVERT_HEAD
        set operation revert
    else if test -f $gitDir/BISECT_LOG
        set operation bisect
    end

    # Upstream behind/ahead
    # Suppress errors in case there is no upstream
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null |
        read --local --delimiter=\t upstreamBehind upstreamAhead
    test "$upstreamBehind" = 0 && set -e upstreamBehind
    test "$upstreamAhead" = 0 && set -e upstreamAhead

    # Git status/stash
    test "$isInsideGitDir" = true && set -l gitSetDirOption -C $gitDir/..

    # Suppress errors in case we are in a bare repo
    set -l gitInfo (git $gitSetDirOption --no-optional-locks status --porcelain 2>/dev/null)
    set -l stash (git $gitSetDirOption stash list 2>/dev/null | count) || set -e stash
    set -l conflicted (string match --regex '^UU' $gitInfo | count) || set -e conflicted
    set -l staged (string match --regex '^[ADMR].' $gitInfo | count) || set -e staged
    set -l dirty (string match --regex '^.[ADMR]' $gitInfo | count) || set -e dirty
    set -l untracked (string match --regex '^\?\?' $gitInfo | count) || set -e untracked

    # Print the information
    printf '%s' \
        (set_color $tide_git_branch_color) $location \
        (set_color $tide_git_operation_color) ' '$operation ' '$step/$totalSteps \
        (set_color $tide_git_upstream_color) ' ⇣'$upstreamBehind ' ⇡'$upstreamAhead \
        (set_color $tide_git_stash_color) ' *'$stash \
        (set_color $tide_git_conflicted_color) ' ~'$conflicted \
        (set_color $tide_git_staged_color) ' +'$staged \
        (set_color $tide_git_dirty_color) ' !'$dirty \
        (set_color $tide_git_untracked_color) ' ?'$untracked
end
