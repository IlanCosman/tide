function _tide_item_jj
    jj root --quiet &>/dev/null || return

    # We want tide to define the colors so disable them
    set -l f
    jj log --ignore-working-copy --no-graph --color never -r @ -T '
        concat(
            change_id.shortest().prefix(), "\0", change_id.shortest().rest(), "\0",
            commit_id.shortest().prefix(), "\0", commit_id.shortest().rest(), "\0",
            bookmarks.map(|b| b.name()).join(" "), "\0",
            if(
                description.first_line().substr(0, 24).starts_with(description.first_line()),
                description.first_line().substr(0, 24),
                description.first_line().substr(0, 23) ++ "…"
            ), "\0",
            if(empty, "1", ""), "\0", if(conflict, "1", ""), "\0",
            if(divergent, "1", ""), "\0", if(hidden, "1", ""), "\0",
            diff.files().len(), "\0", diff.stat().total_added(), "\0", diff.stat().total_removed(), "\0",
        )' 2>/dev/null | while read -lz field
        set -a f $field
    end

    set -l change_prefix $f[1]
    set -l change_rest $f[2]
    set -l commit_prefix $f[3]
    set -l commit_rest $f[4]
    set -l bookmarks $f[5]
    set -l description $f[6]
    set -l empty $f[7]
    set -l conflict $f[8]
    set -l divergent $f[9]
    set -l hidden $f[10]
    set -l files $f[11]
    set -l added $f[12]
    set -l removed $f[13]

    if test -n "$conflict$divergent"
        set -g tide_jj_bg_color $tide_jj_bg_color_urgent
    else if test -z "$empty"
        set -g tide_jj_bg_color $tide_jj_bg_color_unstable
    end

    _tide_print_item jj (set_color $tide_jj_color_change_id)' ' (
        set_color $tide_jj_color_change_id
        echo -ns $change_prefix
        set_color $tide_jj_color_id_shadow
        echo -ns $change_rest

        set_color $tide_jj_color_commit_id
        echo -ns ' '$commit_prefix
        set_color $tide_jj_color_id_shadow
        echo -ns $commit_rest

        test -n "$bookmarks" && begin
            set_color $tide_jj_color_bookmarks
            echo -ns ' '$bookmarks
        end

        test -n "$description" && begin
            set_color $tide_jj_color_description
            echo -ns ' "'$description'"'
        end

        test -n "$conflict" && begin
            set_color $tide_jj_color_conflict
            echo -ns ' conflict'
        end

        test -n "$divergent" && begin
            set_color $tide_jj_color_divergent
            echo -ns ' divergent'
        end

        test -n "$hidden" && begin
            set_color $tide_jj_color_divergent
            echo -ns ' hidden'
        end

        test "$files" != 0 && begin
            set_color $tide_jj_color_diff_added
            echo -ns ' +'$added
            set_color $tide_jj_color_diff_removed
            echo -ns ' -'$removed
        end
    )
end
