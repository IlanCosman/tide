function git_prompt
    # Branch or SHA
    set -l location (git branch --show-current 2>/dev/null) || return
    test -z "$location" && set -l location (git rev-parse --short HEAD)

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
        ' ⇣'$upstreamBehind \
        ' ⇡'$upstreamAhead \
        ' ~'$unmerged \
        ' +'$staged \
        ' !'$dirty \
        ' ?'$untracked \
        ' *'$stash
end