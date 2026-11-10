# RUN: %fish %s
_tide_parent_dirs

function _git
    git $argv >/dev/null 2>&1
end

function _git_item
    _tide_decolor (_tide_item_git)
end

# Create directory
set -l dir (mktemp -d)
mkdir -p $dir/{normal-repo, bare-repo, submodule-repo, massive-status-repo, worktree-repo}

# Not in git repo
cd $dir
_git_item # CHECK:

# -------- normal repo tests --------
cd ./normal-repo
_git init
_git branch -m main

# Branch
_git_item # CHECK: main

# .git dir
cd .git/
_git_item # CHECK: main
cd ..

# Untracked
echo >foo
_git_item # CHECK: main ?1

# Staged
_git add foo
_git_item # CHECK: main +1

git config --local user.email "you@example.com"
git config --local user.name "Your Name"
_git commit -am 'Add foo'

# Dirty
echo hello >foo
_git_item # CHECK: main !1

# Stash
_git stash
_git_item # CHECK: main *1

_git stash pop
_git commit -am 'Append hello to foo'

# SHA
_git checkout HEAD~
_git_item # CHECK: {{@\w*}}

# Tag on a detached checkout
_git tag detached-tag
_git_item # CHECK: #detached-tag
_git tag -d detached-tag

# --- Long branches ---
_git checkout main
_git checkout -b very_long_branch_name
set -lx tide_git_truncation_length 10
set -lx tide_git_truncation_strategy
_git_item # CHECK: very_long…
set -lx tide_git_truncation_strategy l
_git_item # CHECK: …anch_name

# Branch same length as tide_git_truncation_length
_git checkout -b 10charhere
_git_item # CHECK: 10charhere

# -------- bare repo tests --------
cd $dir/bare-repo
_git init --bare
_git branch -m main
_git_item # CHECK: bare

# Bare repository containing sibling worktrees
cd $dir/worktree-repo
_git clone --bare $dir/normal-repo .git
_git symbolic-ref HEAD refs/heads/main
_git_item # CHECK: bare
set -lx tide_git_icon 
_git_item # CHECK:  bare
set -lx tide_git_icon

cd .git
_git_item # CHECK: bare

# Detached bare HEAD, with and without a tag
_git update-ref --no-deref HEAD main
_git_item # CHECK: bare
_git tag bare-tag
_git_item # CHECK: bare
_git symbolic-ref HEAD refs/heads/main
cd ..

_git worktree add main main
_git_item # CHECK: bare wt:1
_git worktree add -b topic topic main
_git_item # CHECK: bare wt:2

# Locked worktrees count; missing, prunable worktrees do not
_git worktree lock topic
_git_item # CHECK: bare wt:2
_git worktree add -b removed removed main
command rm -r removed
_git_item # CHECK: bare wt:2

# Paths with newlines cannot introduce extra porcelain fields
_git worktree add -b unusual "unusual
HEAD fake"
_git_item # CHECK: bare wt:3
_git worktree remove "unusual
HEAD fake"

# Icons are optional; the bare label and count remain readable without them
set -lx tide_git_icon 
_git_item # CHECK:  bare wt:2
set -lx tide_git_icon
_git_item # CHECK: bare wt:2

# A failed worktree query must not imply zero worktrees
mock git "worktree list --porcelain -z" "return 1"
_git_item # CHECK: bare wt:?
mock --erase git

cd main
_git_item # CHECK: main
cd ../topic
_git_item # CHECK: topic

# ------ submodule repo test ------
cd $dir/submodule-repo
_git init
_git branch -m main

# temporary workaround for git bug https://bugs.launchpad.net/ubuntu/+source/git/+bug/1993586
_git -c protocol.file.allow=always submodule add $dir/normal-repo
_git_item # CHECK: main +2
cd normal-repo
_git_item # CHECK: 10charhere
cd ..

echo >new_main_git_file
_git_item # CHECK: main +2 ?1
echo >normal-repo/new_submodule_file
_git_item # CHECK: main +2 !1 ?1
cd normal-repo
_git_item # CHECK: 10charhere ?1

# --- Massive git status ---
cd $dir/massive-status-repo
_git init
_git branch -m main
mock git "--no-optional-locks status --porcelain" "string repeat -n100000 'D  some-file-name'\n"
_git_item # CHECK: main +100000

# ------ cleanup ------
command rm -r $dir
