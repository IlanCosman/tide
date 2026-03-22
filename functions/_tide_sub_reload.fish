function _tide_sub_reload
    # In VSCode shell integration, fish_prompt may be redefined from stdin by
    # Tide's wrapper, so reload the prompt from Tide's file on disk instead of
    # asking the live function where it came from.
    source (string replace -r '[^/]+$' fish_prompt.fish (functions --details _tide_sub_reload))
    _tide_vscode_wrap_prompt 2>/dev/null || true
end
