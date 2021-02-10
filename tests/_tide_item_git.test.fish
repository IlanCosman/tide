# RUN: %fish %s

function _git
    _tide_decolor (_tide_item_git)
end

# Not in git repo
_git # CHECK:

# Initial setup
rm -rf gitItemTest
mkdir -p gitItemTest
cd gitItemTest
git init >/dev/null 2>&1
git checkout -b main >/dev/null 2>&1

# Branch
_git # CHECK: main

# Untracked
touch foo
_git # CHECK: main ?1

# Staged
git add foo >/dev/null 2>&1
_git # CHECK: main +1

git commit -am 'Add foo' >/dev/null 2>&1

# Dirty
echo hello > foo
_git # CHECK: main !1

# Stash
git stash >/dev/null 2>&1
_git # CHECK: main *1

git stash pop >/dev/null 2>&1
git commit -am 'Append hello to foo' >/dev/null 2>&1

# SHA
git checkout HEAD~ >/dev/null 2>&1
_git # CHECK: {{\w{8}…}}

# GIT_DIR!
cd .git
_git # CHECK: GIT_DIR!


