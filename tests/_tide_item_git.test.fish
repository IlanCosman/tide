# RUN: %fish %s

function _git
    git $argv >/dev/null 2>&1
end

function _git_item
    _tide_decolor (_tide_item_git)
end

# Create directory
set -l dir ~/gitItemTest
rm -rf $dir
mkdir -p $dir
cd $dir

# Not in git repo
_git_item # CHECK:

# Create git repo and main branch
_git init
_git checkout -b main

# Branch
_git_item # CHECK: main

# Untracked
touch foo
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
_git_item # CHECK: {{\w{8}…}}

# GIT_DIR!
cd .git
_git_item # CHECK: GIT_DIR!
