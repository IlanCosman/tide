function git_prompt
    # Branch or SHA
    set -l location (git branch --show-current 2>/dev/null) || return
    test -z "$location" && set -l location (git rev-parse --short HEAD)

    # Upstream behind/ahead
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null |
    read --local --delimiter=\t upstreamBehind upstreamAhead

    test "$upstreamBehind" = 0 && set -e upstreamBehind
    test "$upstreamAhead" = 0 && set -e upstreamAhead

    # Git status information
    set -l gitInfo (git status --porcelain | string trim)

    set -l deletedCount (string match --regex '^D' $gitInfo | count) || set -e deletedCount
    set -l modifiedCount (string match --regex '^M' $gitInfo | count) || set -e modifiedCount
    set -l stagedCount (string match --regex '^A' $gitInfo | count) || set -e stagedCount
    set -l untrackedCount (string match --regex '^\?\?' $gitInfo | count) || set -e untrackedCount

    printf '%s' \
        $location' ' \
        $upstreamBehind"$upstreamBehindIcon" \
        $upstreamAhead"$upstreamAheadIcon" \
        $deletedCount"$deletedIcon" \
        $modifiedCount"$modifiedIcon" \
        $stagedCount"$stagedIcon" \
        $untrackedCount"$untrackedIcon"
end