function _tide_on_pwd -v PWD
    set -g _tide_pwd (string replace $HOME '~' $PWD)
    set -g _tide_split_pwd (string split --no-empty '/' $_tide_pwd)

    set -g git_dir (git rev-parse --show-toplevel 2>/dev/null)

    _tide_pwd_set_anchors
end