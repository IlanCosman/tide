function _tide_mark_stale_git_prompt -a prompt_var
    set -q _tide_git_stale_color || return
    set -q $prompt_var || return

    set -l stale_marker __tide_prompt_stale
    set -l marked_prompt
    for prompt in $$prompt_var
        string match -q "$stale_marker*" -- $prompt || set prompt $stale_marker$prompt
        set -a marked_prompt $prompt
    end

    set $prompt_var $marked_prompt
end
