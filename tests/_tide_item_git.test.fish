# RUN: %fish %s
_tide_parent_dirs
_tide_cache_variables

function _git
    git $argv >/dev/null 2>&1
end

function _git_item
    _tide_decolor (_tide_item_git)
end

# Create directory
set -l dir (mktemp -d)
mkdir -p $dir/{normal-repo, bare-repo, submodule-repo, massive-status-repo}

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

# -------- bare repo test --------
cd $dir/bare-repo
_git init --bare
_git branch -m main
_git_item # CHECK: main

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
