function _tide_item_github_pr
    command -q gh || return
    set -l branch (git branch --show-current 2>/dev/null) || return
    test -n "$branch" || return

    set -l cache_dir (set -q TMPDIR && echo $TMPDIR || echo /tmp)/tide_github_pr
    set -l git_toplevel (git rev-parse --show-toplevel 2>/dev/null) || return
    set -l cache_file $cache_dir/(string replace -a / _ -- $git_toplevel/$branch)

    # Check cache (5 min TTL — gh pr view is a network call, not suitable for every prompt)
    if test -f "$cache_file"
        set -l now (date +%s)
        set -l mtime (
            switch (uname)
                case Darwin
                    command stat -f %m "$cache_file"
                case '*'
                    command stat -c %Y "$cache_file"
            end
        )
        if test (math $now - $mtime) -lt 300
            set -l cached (command cat "$cache_file")
            test "$cached" != none &&
                _tide_print_item github_pr $tide_github_pr_icon' ' $cached
            return
        end
    end

    # Fetch from GitHub (Tide renders in background so this won't block user input)
    command mkdir -p $cache_dir
    if gh pr view --json number --jq '.number' 2>/dev/null | read -l pr_number
        echo "PR #$pr_number" >$cache_file
        _tide_print_item github_pr $tide_github_pr_icon' ' "PR #$pr_number"
    else
        echo none >$cache_file
    end
end
