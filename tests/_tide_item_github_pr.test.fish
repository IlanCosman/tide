# RUN: %fish %s
_tide_parent_dirs

function _github_pr
    set -g prev_bg_color
    _tide_decolor (_tide_item_github_pr)
end

set -lx tide_github_pr_icon

# --- gh not installed ---
mock gh "" false
_github_pr # CHECK:

# --- not in a git repo ---
set -l tmpdir (mktemp -d)
cd $tmpdir
mock gh "" true
_github_pr # CHECK:

# --- in a git repo, no PR ---
command mkdir -p $tmpdir/repo
cd $tmpdir/repo
git init -q
git checkout -q -b my-feature 2>/dev/null
git config user.email "test@test.com"
git config user.name Test
echo >foo
git add foo
git commit -q -m init

# Clear cache to force fresh lookup
set -l cache_dir (set -q TMPDIR && echo $TMPDIR || echo /tmp)/tide_github_pr
command rm -rf $cache_dir

mock gh "pr view --json number --jq" false
_github_pr # CHECK:

# --- in a git repo, with PR ---
command rm -rf $cache_dir

mock gh "pr view --json number --jq" "echo 1234"
_github_pr # CHECK:  PR #1234

# --- cached result is returned ---
# Cache was written by previous call, mock a different number to prove cache is used
mock gh "pr view --json number --jq" "echo 9999"
_github_pr # CHECK:  PR #1234

# --- cached 'none' suppresses output ---
command rm -rf $cache_dir
mock gh "pr view --json number --jq" false
_github_pr # CHECK:

# Verify 'none' is cached — mock a PR but cache says none
mock gh "pr view --json number --jq" "echo 5555"
_github_pr # CHECK:

# --- cleanup ---
command rm -rf $tmpdir
command rm -rf $cache_dir
