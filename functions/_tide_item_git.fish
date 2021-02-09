function _tide_item_git
    # Branch or SHA
    set -l branch (git branch --show-current 2>/dev/null) || return
    # --quiet ensures that it won't complain if there are no commits
    git rev-parse --quiet \
        --is-inside-work-tree \
        --git-dir \
        --short=8 HEAD | read --local --line isInsideWorkTree gitDir sha

    set -l location
    if test "$isInsideWorkTree" = false
        set location GIT_DIR!
    else if test -n "$branch"
        set location $branch
    else
        set location $sha…
    end

    # Operation
    set -l operation
    set -l step
    set -l totalSteps

    if test -d $gitDir/rebase-merge
        set step (cat $gitDir/rebase-merge/msgnum 2>/dev/null)
        set totalSteps (cat $gitDir/rebase-merge/end 2>/dev/null)
        if test -f $gitDir/rebase-merge/interactive
            set operation rebase-i
        else
            set operation rebase-m
        end
    else if test -d $gitDir/rebase-apply
        set step (cat $gitDir/rebase-apply/next 2>/dev/null)
        set totalSteps (cat $gitDir/rebase-apply/last 2>/dev/null)
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
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null |
    read --local --delimiter=\t upstreamBehind upstreamAhead
    test "$upstreamBehind" = 0 && set -e upstreamBehind
    test "$upstreamAhead" = 0 && set -e upstreamAhead

    # Git status/stash
    set -l staged
    set -l dirty
    set -l untracked
    set -l conflicted
    set -l stash

    if test "$isInsideWorkTree" = true
        set -l gitInfo (git status --porcelain)
        set staged (string match --regex '^[ADMR] ' $gitInfo | count) || set -e staged
        set dirty (string match --regex '^ [ADMR]' $gitInfo | count) || set -e dirty
        set untracked (string match --regex '^\?\?' $gitInfo | count) || set -e untracked
        set conflicted (string match --regex '^UU' $gitInfo | count) || set -e conflicted
        set stash (git stash list | count) || set -e stash
    end

    # Print the information
    printf '%s' \
        (set_color $tide_git_branch_color) $location \
        (set_color $tide_git_operation_color) ' '$operation ' '$step/$totalSteps \
        (set_color $tide_git_upstream_color) ' ⇣'$upstreamBehind ' ⇡'$upstreamAhead \
        (set_color $tide_git_conflicted_color) ' ~'$conflicted \
        (set_color $tide_git_staged_color) ' +'$staged \
        (set_color $tide_git_dirty_color) ' !'$dirty \
        (set_color $tide_git_untracked_color) ' ?'$untracked \
        (set_color $tide_git_stash_color) ' *'$stash
end
