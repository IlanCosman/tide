function git_prompt
    # Branch or SHA
    set -l location (git branch --show-current 2>/dev/null) || return
    git rev-parse --git-dir --short HEAD | read --local --line gitDir sha
    test -z "$location" && set location $sha

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
        set operation cherry-picking
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

    # Git status info
    set -l gitInfo (git status --porcelain)
    set -l staged (string match --regex '^[ADMR] ' $gitInfo | count) || set -e staged
    set -l dirty (string match --regex '^ [ADMR]' $gitInfo | count) || set -e dirty
    set -l untracked (string match --regex '^\?\?' $gitInfo | count) || set -e untracked
    set -l unmerged (string match --regex '^UU' $gitInfo | count) || set -e unmerged

    # Stash
    set -l stash (git stash list | count) || set -e stash

    # Print the information
    printf '%s' \
        ' '$location \
        ' '$operation \
        ' '$step/$totalSteps \
        ' ⇣'$upstreamBehind \
        ' ⇡'$upstreamAhead \
        ' ~'$unmerged \
        ' +'$staged \
        ' !'$dirty \
        ' ?'$untracked \
        ' *'$stash
end