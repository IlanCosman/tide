# AGENTS.md

Tide is a prompt for the [fish shell][fish], written in fish and installed with [Fisher][]. Coding agents read this file (Claude Code through `CLAUDE.md`, which imports it), so it holds only what most sessions need. [CONTRIBUTING.md][] has the style and naming conventions, and Claude Code's procedures are skills in `.claude/skills/`.

## Principles

- Change only what you were asked to. When the user then asks for more ("also do Y"), add it to the earlier work instead of redoing that work.
- Users' `tide_*` universal variables, item names and `tide` subcommands are Tide's public interface: renaming or removing one breaks saved configurations. Ask before doing it, and don't add compatibility shims or aliases unasked either.
- "Consistent with the codebase" doesn't justify a worse design. Existing code is someone's best effort, not a spec: check what depends on it before keeping or removing it. When something looks like a workaround, say so and propose the standard way.

## Layout

- `functions/`: one autoloaded function per file. Most items are `_tide_item_<name>.fish` (`_tide_item_pwd` is defined in `_tide_1_line_prompt.fish` and `_tide_2_line_prompt.fish`), subcommands are `_tide_sub_<name>.fish`, and `tide.fish` holds the version number.
- `functions/fish_prompt.fish` renders the prompt in a background fish process, which hands it back through the universal variable `_tide_prompt_$fish_pid`.
- `functions/tide/configure/` is the `tide configure` wizard ([ARCHITECTURE.md][] has its flowchart). Its `configs/` hold each style's defaults for every item, and `icons.fish` the icons.
- `conf.d/_tide_init.fish` handles Fisher's install, update and uninstall events.
- `tests/` has [littlecheck][] tests, one `*.test.fish` per item for most items, which fake external commands with `mock` from [clownfish][].
- User docs live in the [wiki][], not in this repo.

## Commands

- The shell Claude Code runs commands in may be bash or zsh, not fish. Run fish code with `fish -c '...'` or through `make`, whose recipes run in fish.
- `make fmt` formats with `fish_indent`, and `make lint` syntax-checks every file with `fish --no-execute`. CI runs both, plus MegaLinter on Markdown, YAML, JSON and the workflows.
- Never run a bare `make`, `make install` or `make test`: they work on your real fish config. They install this checkout, resetting your `tide_*` settings to the lean defaults. If Fisher already installed Tide, it refuses, and whatever still runs tests the installed release, not your changes. `make test` also installs clownfish and writes a `conf.d` file that sets `TERM` and `_tide_side` in every new shell. Give the tests a throwaway config dir instead (the command works in bash, zsh and fish):

  ```sh
  env XDG_CONFIG_HOME="$(mktemp -d)" make test
  ```

  The suite takes seconds, but each run downloads Fisher and clownfish into the new dir, so it needs the network.

- To check Markdown, YAML and JSON before CI's MegaLinter does: `npx --yes prettier@3 --check <files>`, `npx --yes markdownlint-cli --config .github/linters/.markdownlint.json <files>`, and `npx --yes editorconfig-checker <files>`. The last one rejects indentation that isn't a multiple of 2 in Markdown, which prettier produces for text continued under a numbered list item.

## Code

- The prompt runs before every command, so speed matters. Prefer fish builtins (`string`, `path`, `test`, `math`) to external commands. A tool-specific item goes in `_tide_remove_unusable_items`'s list, which drops it once per shell when its tool isn't installed, so the item itself needn't check on every prompt.
- Code must work on macOS and Linux. BSD and GNU tools differ (`sed -i`, `date`, `stat`, `mktemp`), so avoid their flags or branch on the OS.
- Only the latest fish is supported, but the wiki's [fish version compatibility][] table says which fish versions each Tide release runs on (currently fish 4.0 and later). Using a feature from a newer fish changes that table, so call it out in the PR.
- Add or update tests in `tests/` with a change to an item, as the PR template asks.
- The maintainer writes the changelog at release time, so don't add entries in a regular PR.

## Git and PRs

- Work in a worktree or a branch, never on `main`. Stage explicit paths, never `git add .` or `-A`.
- Never rewrite pushed history: no force push, no rebase of pushed commits. Fix forward with a new commit. `.claude/settings.json` blocks force pushes, `--amend`, `reset --hard` and `branch -D` outright, so ask the user to run one of those if it's really needed.
- Many issues already have a fix in an open PR, or in [plttn/tide][], a community continuation that merged many of them. Check both before writing one, and credit the original author when you port a fix (a `Co-authored-by:` trailer).
- PR text uses backticks for code and short bullets. To mention an issue a PR doesn't close, put a word between the keyword and the number ("fixes the bug from #630"), since "fix #630" closes it. After each push, update the title and description to match the diff.
- Open your PRs as drafts (`gh pr create --draft`), then run Claude Code's `red-team-pr` skill. Marking a PR ready, merging and releasing are the maintainer's call.
- Releases follow the checklist in [CONTRIBUTING.md][]. Pushing a `vX.Y.Z` tag runs `release.yml`, which moves the `vX` and `vX.Y` tags and publishes the GitHub release.

[architecture.md]: ARCHITECTURE.md
[clownfish]: https://github.com/IlanCosman/clownfish
[contributing.md]: CONTRIBUTING.md
[fish]: https://fishshell.com/
[fish version compatibility]: https://github.com/IlanCosman/tide/wiki/Fish-version-compatibility
[fisher]: https://github.com/jorgebucaran/fisher
[littlecheck]: https://github.com/ridiculousfish/littlecheck
[plttn/tide]: https://github.com/plttn/tide
[wiki]: https://github.com/IlanCosman/tide/wiki
