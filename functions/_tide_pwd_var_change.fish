function _tide_pwd_var_change --on-variable PWD
    set -l preDirNumberPwd (string replace $HOME '~' $PWD)
    set -l preDirNumberPwdSplit (string split '/' $preDirNumberPwd)

    set -g _tide_split_pwd $preDirNumberPwdSplit[(math -s0 -$tide_pwd_max_dirs)..-1]
    set -g _tide_pwd (string join '/' $_tide_split_pwd)

    set -g _tide_git_dir (git rev-parse --show-toplevel 2>/dev/null)

    set -g _tide_pwd_anchors

    if contains 'first' $tide_pwd_anchors
        if test -n "$_tide_split_pwd[1]"
            set -a _tide_pwd_anchors $_tide_split_pwd[1]
        else
            set -a _tide_pwd_anchors $_tide_split_pwd[2]
        end
    end
    if contains 'last' $tide_pwd_anchors
        set -a _tide_pwd_anchors $_tide_split_pwd[-1]
    end
    if contains 'git' $tide_pwd_anchors
        set -a _tide_pwd_anchors (string split -r -m1 '/' "$_tide_git_dir")[2]
    end

    _tide_pwd
end