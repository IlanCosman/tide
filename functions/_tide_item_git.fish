function _tide_item_git
    if git branch --show-current 2>/dev/null | string replace -r "(.{$tide_git_truncation_length}).+" '$1…' | read -l location
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        set location $_tide_location_color$location
    else if test $pipestatus[1] != 0
        return
    else if git tag --points-at HEAD | string replace -r "(.{$tide_git_truncation_length}).+" '$1…' | read location
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        set location '#'$_tide_location_color$location
    else
        git rev-parse --git-dir --is-inside-git-dir --short HEAD | read -fL gdir in_gdir location
        set location @$_tide_location_color$location
    end

    # Operation
    if test -d $gdir/rebase-merge
        read -f step <$gdir/rebase-merge/msgnum
        read -f total_steps <$gdir/rebase-merge/end
        test -f $gdir/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
    else if test -d $gdir/rebase-apply
        read -f step <$gdir/rebase-apply/next
        read -f total_steps <$gdir/rebase-apply/last
        if test -f $gdir/rebase-apply/rebasing
            set -f operation rebase
        else if test -f $gdir/rebase-apply/applying
            set -f operation am
        else
            set -f operation am/rebase
        end
    else if test -f $gdir/MERGE_HEAD
        set -f operation merge
    else if test -f $gdir/CHERRY_PICK_HEAD
        set -f operation cherry-pick
    else if test -f $gdir/REVERT_HEAD
        set -f operation revert
    else if test -f $gdir/BISECT_LOG
        set -f operation bisect
    end

    # Git status/stash + Upstream behind/ahead
    test $in_gdir = true && set -l _set_dir_opt -C $gdir/..
    # Suppress errors in case we are in a bare repo or there is no upstream
    stat=(git $_set_dir_opt --no-optional-locks status --porcelain 2>/dev/null) \
        string match -qr '(0|(?<stash>.*))\n(0|(?<conflicted>.*))\n(0|(?<staged>.*))
(0|(?<dirty>.*))\n(0|(?<untracked>.*))(\n(0|(?<behind>.*))\t(0|(?<ahead>.*)))?' \
        "$(git $_set_dir_opt stash list 2>/dev/null | count
        string match -r ^UU $stat | count
        string match -r ^[ADMR]. $stat | count
        string match -r ^.[ADMR] $stat | count
        string match -r '^\?\?' $stat | count
        git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"

    if test -n "$operation$conflicted"
        set -g tide_git_bg_color $tide_git_bg_color_urgent
    else if test -n "$staged$dirty$untracked"
        set -g tide_git_bg_color $tide_git_bg_color_unstable
    end

    _tide_print_item git $_tide_location_color$tide_git_icon' ' (set_color white; echo -ns $location
        set_color $tide_git_color_operation; echo -ns ' '$operation ' '$step/$total_steps
        set_color $tide_git_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
        set_color $tide_git_color_stash; echo -ns ' *'$stash
        set_color $tide_git_color_conflicted; echo -ns ' ~'$conflicted
        set_color $tide_git_color_staged; echo -ns ' +'$staged
        set_color $tide_git_color_dirty; echo -ns ' !'$dirty
        set_color $tide_git_color_untracked; echo -ns ' ?'$untracked)
end
