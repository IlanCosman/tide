function git_prompt
    set -l location (git branch --show-current 2>/dev/null) || return
    test -z "$location" && set -l location (git rev-parse --short HEAD)

    set -l gitInfo (git status --porcelain | string trim)

    set -l deletedCount (string match --regex '^D' $gitInfo | count) || set -e deletedCount
    set -l modifiedCount (string match --regex '^M' $gitInfo | count) || set -e modifiedCount
    set -l stagedCount (string match --regex '^A' $gitInfo | count) || set -e stagedCount
    set -l untrackedCount (string match --regex '^\?\?' $gitInfo | count) || set -e untrackedCount

    printf '%s' $location \
        $deletedCount"$deletedIcon" \
        $modifiedCount"$modifiedIcon" \
        $stagedCount"$stagedIcon" \
        $untrackedCount"$untrackedIcon"
end