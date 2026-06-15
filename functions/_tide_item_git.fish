function _tide_item_git
    git rev-parse --git-dir --is-inside-git-dir 2>/dev/null | read -fL gdir in_gdir
    or return

    # Operation
    if test -d $gdir/rebase-merge
        # Turn ANY into ALL, via double negation
        if not path is -v $gdir/rebase-merge/{msgnum,end}
            read -f step <$gdir/rebase-merge/msgnum
            read -f total_steps <$gdir/rebase-merge/end
        end
        test -f $gdir/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
    else if test -d $gdir/rebase-apply
        if not path is -v $gdir/rebase-apply/{next,last}
            read -f step <$gdir/rebase-apply/next
            read -f total_steps <$gdir/rebase-apply/last
        end
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
    set -l stat (git $_set_dir_opt --no-optional-locks status --porcelain --branch 2>/dev/null)

    set -l location
    set -l ahead (string match -r '(?<=ahead )\d+' $stat[1])
    set -l behind (string match -r '(?<=behind )\d+' $stat[1])

    set -l conflicted (count (string match -r '^UU' $stat[2..]))
    set -l staged (count (string match -r '^[ADMR]' $stat[2..]))
    set -l dirty (count (string match -r '^.[ADMR]' $stat[2..]))
    set -l untracked (count (string match -r '^\?\?' $stat[2..]))

    # Get location
    set -l branch (string split '...' $stat[1])[1]
    set branch (string replace -r '^## (?:No commits yet on )?' '' $branch)

    if test -n "$branch" -a "$branch" != "HEAD (no branch)"
        set location (echo -ns $branch | string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length)
        set location $_tide_location_color$location
    else if git branch --show-current 2>/dev/null | string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length | read -f location
        set location $_tide_location_color$location
    else if git tag --points-at HEAD 2>/dev/null | string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length | read location
        set location '#'$_tide_location_color$location
    else
        git rev-parse --short HEAD 2>/dev/null | read -f location
        set location @$_tide_location_color$location
    end

    set -l stash (git $_set_dir_opt stash list 2>/dev/null | count)

    test "$stash" = 0 && set -e stash
    test "$conflicted" = 0 && set -e conflicted
    test "$staged" = 0 && set -e staged
    test "$dirty" = 0 && set -e dirty
    test "$untracked" = 0 && set -e untracked

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
