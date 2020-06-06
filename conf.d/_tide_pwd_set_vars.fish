function _tide_pwd_set_anchors -v tide_pwd_anchors
    set -g anchors

    set -l splitGitDir (string replace $HOME '~' $git_dir | string split --no-empty '/')

    if contains 'first' $tide_pwd_anchors
        set -a anchors 1
    end
    if contains 'last' $tide_pwd_anchors
        set -a anchors (count $_tide_split_pwd)
    end
    if contains 'git' $tide_pwd_anchors
        set -a anchors (count $splitGitDir)
    end

    _tide_pwd
end

function _tide_pwd_set_max_length -v tide_pwd_truncate_margin -s WINCH
    set -g max_length (math $COLUMNS-$tide_pwd_truncate_margin)

    _tide_pwd
end

function _tide_pwd_set_truncated_dir_color -v tide_pwd_color_truncated_dirs
    set -g truncatedDirColor (set_color $tide_pwd_color_truncated_dirs)

    _tide_pwd
end

function _tide_pwd_set_anchor_color -v tide_pwd_color_anchors
    set -g anchorColor (set_color -o $tide_pwd_color_anchors)

    _tide_pwd
end

function _tide_pwd_set_dir_color -v tide_pwd_color_dirs
    set -g dirColor (set_color $tide_pwd_color_dirs)

    _tide_pwd
end