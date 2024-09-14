function _tide_item_jj
    if not command -sq jj; or not jj root --quiet &>/dev/null
        return 1
    end

    set jj_status (jj log -r@ -n1 --no-graph --color always -T '
    separate(" ",
        bookmarks.map(|x| if(
            x.name().substr(0, 10).starts_with(x.name()),
            x.name().substr(0, 10),
            x.name().substr(0, 9) ++ "…")
        ).join(" "),
        tags.map(|x| if(
            x.name().substr(0, 10).starts_with(x.name()),
            x.name().substr(0, 10),
            x.name().substr(0, 9) ++ "…")
        ).join(" "),
        surround("\"","\"",
            if(
                description.first_line().substr(0, 24).starts_with(description.first_line()),
                description.first_line().substr(0, 24),
                description.first_line().substr(0, 23) ++ "…"
            )
        ),
        change_id.shortest(),
        commit_id.shortest(),
        diff.files().len() ++ "m",
        diff.stat().total_added() ++ "+",
        diff.stat().total_removed() ++ "-",
        if(conflict, "conflict"),
        if(divergent, "divergent"),
        if(hidden, "hidden"),
    )' | string trim)
    _tide_print_item jj $tide_jj_icon' ' "($jj_status)"
end
