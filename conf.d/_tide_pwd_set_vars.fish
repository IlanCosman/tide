function _tide_pwd_set_anchors -v tide_pwd_anchors
    set -g _tide_pwd_anchors

    set -l splitGitDir (string replace $HOME '~' $_tide_git_dir | string split --no-empty '/')

    if contains 'first' $tide_pwd_anchors
        set -a _tide_pwd_anchors 1
    end
    if contains 'last' $tide_pwd_anchors
        set -a _tide_pwd_anchors (count $_tide_split_pwd)
    end
    if contains 'git' $tide_pwd_anchors
        set -a _tide_pwd_anchors (count $splitGitDir)
    end

    _tide_pwd
end

function _tide_pwd_set_max_length -v tide_pwd_truncate_margin -s WINCH
    set -g _tide_pwd_max_length (math $COLUMNS-$tide_pwd_truncate_margin)

    _tide_pwd
end

function _tide_pwd_set_truncated_dir_color -v tide_pwd_color_truncated_dirs
    set -g _tide_pwd_truncated_dir_color (set_color $tide_pwd_color_truncated_dirs)

    _tide_pwd
end

function _tide_pwd_set_anchor_color -v tide_pwd_color_anchors
    set -g _tide_pwd_anchor_color (set_color -o $tide_pwd_color_anchors)

    _tide_pwd
end

function _tide_pwd_set_dir_color -v tide_pwd_color_dirs
    set -g _tide_pwd_dir_color (set_color $tide_pwd_color_dirs)

    _tide_pwd
end