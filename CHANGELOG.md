# Changelog

## [v6.0.1][] (Oct 04 2023)

### Bug fixes

- Restore missing space character after transient prompts

## [v6.0.0][] (Oct 03 2023)

### Features

- Add transient prompt setting, which automatically collapses old prompts for more condensed scrollback
- Add automatic configuration, which lets users automate the configuration wizard
- Add `tide reload` subcommand, to re-initialize the prompt without requiring a new shell session
- Replace `virtual_env` item with a new and improved `python` item
- Replace `chruby` item with a new and improved `ruby` item ([#437][] - @cmer)
- Extensive use of `string match` variable setting for minor speedups
- Reduce globbing in `pwd` item, which can be costly on slow filesystems

## [v5.6.0][] (Jul 04 2023)

### Features

- Display toolbox name when in a toolbox ([#343][])
- Add distrobox item ([#337][] - @daudix-UFO)
- Add pulumi item ([#335][] - @devansh08)
- Add elixir Item ([#373] - @aselder)
- Git branch truncation has reverted to keeping the beginning
  - Use `set tide_git_truncation_strategy l` to keep the end instead
- Add direnv item ([#398] - @branchvincent)
- Never truncate directories to just a dot ([#399])

### Bug fixes

- Fix an error message when `git status` produces a huge amount of information ([#394][])

## [v5.5.1][] (Sep 14 2022)

### Bug fixes

- Fix errors when in weird directories like `has spaces` or `--has dashes` ([#346][])

## [v5.5.0][] (Sep 5 2022)

### Features

- Add crystal language item ([#322][] - @rrevi)
- Tide now looks in parent directories for special files, such as when displaying tool versions ([#323][])
- Tide now truncates the beginning of git branch names instead of the end
- A new variable, `tide_context_hostname_parts` lets you choose how many parts of the hostname, split on dots, to show. For example, if your hostname is `foo.bar.baz`:
  - With `set tide_context_hostname_parts 5` you would see `user@foo.bar.baz`
  - With `set tide_context_hostname_parts 1` you would see `user@foo` (this is the new default)
  - With `set tide_context_hostname_parts 0` you would see `user`

### Bug fixes

- Display the correct versions of tools when PATH has been altered, e.g. by nvm ([#303][], [#330][] - @9999years)

## [v5.4.0][] (Jul 29 2022)

### Features

- Add nix_shell item ([#305][] - @oati)
- vi_mode
  - insert mode is now configurable
  - better defaults inspired by spacevim
- Check for problems on installation, e.g. old Fish version
- Use the new `EUID` variable in Fish 3.5 to more accurately detect elevated privileges
- Various performance improvements

### Bug fixes

- The first pwd segment is no longer highlighted as anchored. It was already not functionally anchored.

## [v5.3.0][] (May 02 2022)

### Features

- Support multiple 'default' contexts for Docker ([#283][] - @halostatue)
- Add aws item ([#293][] - @okravtsov)
- Add os icons for RHEL, Android, and Windows ([#288][], [#289][], [#295][], - @jose1711)

### Bug fixes

- Fix bug where git submodule information would not display ([#290][])

## [v5.2.2][] (Apr 12 2022)

### Bug fixes

- _Actually_ fix the bug with detection of opensuse ([#277][])

## [v5.2.1][] (Apr 10 2022)

### Bug fixes

- Fix bug with detection of opensuse ([#277][])

## [v5.2.0][] (Apr 07 2022)

### Features

- Add branding colors to os logos when in rainbow mode ([#220][])

## [v5.1.2][] (Apr 03 2022)

### Bug fixes

- Fix extra space on single line lean ([#274][])

## [v5.1.1][] (Apr 01 2022)

### Bug fixes

- Fix java item for old jdks ([#271][])

## [v5.1.0][] (Mar 31 2022)

### Bug fixes

- Use `string length --visible` to allow for emojis in the prompt ([#134][])
- Only replace `$HOME` with `~` if at beginning of PWD ([#250][])
- Repaint prompt when `$COLUMNS` changes ([#254][])

### Features

- New items
  - `private_mode` ([#157][])
  - `terraform` ([#203][] - @radek-sprta)
  - `toolbox` ([#211][])
  - `docker`, disabled by default ([#231][] - @Crocmagnon)
  - `java` ([#244][] - @cr-mitmit)
- Don't require pressing enter for each menu in configuration wizard ([#187][] - @branchvincent)
- Truncate git branches/tags when they get too long ([#221][])
- Performance improvements
  - Cache variables once on fish startup
  - Use `read` instead of command substitution when possible
  - Combine command substitutions
  - Some other, extremely tiny, extremely evil speed boosts
- Improve `bug-report` command
  - Add fish startup time
  - Add fisher plugins

## [v5.0.1][] (Aug 13 2021)

### Bug fixes

- Fixed a bug which caused the prompt to not appear immediately in new shells ([#171][])
- Fixed a bug where `tide_context_color_root` was not correctly set

## [v5.0.0][] (Aug 11 2021)

### Deprecations/Warnings

- `main` is now a development branch. Users should instead install from version tags
  - e.g. `fisher install ilancosman/tide@v5`
- Variable naming scheme has been overhauled, some items have been renamed ([#105][])

### Features

- Run pwd after all other items, which allows it to precisely react to prompt length ([#131][])
- `git` item improvements
  - Display git tag when available ([#154][])
  - Add special characters to indicate git tags and shas ([#154][])
  - Add git icon ([#154][])
  - Add changing background color in rainbow style ([#163][])
- New items
  - `shlvl` ([#156][] - @kidonng)
  - `go` ([#174][] - @dr-emacs)
  - `kubectl` ([#178][] - @branchvincent)
  - `node` item has replaced `nvm` item ([#181][] - @branchvincent)
- Display pipenv virtual environments better in `virtual_env` item.
- Performance improvements

### Bug fixes

- Check for `python3` in addition to `python` before removing virtual_env item ([#162][])
- Don't set `fish_term24bit`, which was messing up colors

## [v4.3.4][] (Apr 14 2021)

- Git item now works correctly in bare git repositories ([#145][])
- Git item now actually works in `.git` directory, and added tests to make sure
- Made `tide bug-report` more powerful and also check for oh-my-fish on the user's machine

## [v4.3.3][] (Apr 11 2021)

### Bug fixes

- Git item now works correctly in `.git` directory and in submodules ([#138][])
- Vi mode prompt char will display correct `$status` ([#126][])
- `alt+arrow` directory switching will work as before ([#139][])
- Avoid killing user's background jobs

## [v4.3.2][] (Mar 26 2021)

### Bug fixes

- Fixed a bug where git staged/dirty counters wouldn't display
- Use `$status` instead of `$pipestatus[-1]` to account for the `not` command.
- Safer fix for the commandline not highlighting bug ([#130][])

## [v4.3.1][] (Mar 24 2021)

### Bug fixes

- Fixed a bug where the commandline wouldn't highlight on startup ([#130][])

## [v4.3.0][] (Mar 22 2021)

### Features

- Remove on startup items that the user doesn't have a required tool for
- Always add a space after the prompt, even without `prompt_char` item ([#129][])

### Bug fixes

- Fix pwd markers which had been broken for a while
- Don't error when the left prompt is too long ([#121][] - @mfossen)
- Fix multi-line prompt when there are no items on the second line

### CI/Testing

- Use mega-linter instead of super-linter
- Fix bug in release action

## [v4.2.0][] (Mar 04 2021)

### Features

- Add PHP item ([#91][])
- Add chruby item ([#100][])

### Bug fixes

- Load fish_prompt only if session is interactive ([#107][] - @chvolkmann)
- Make virtual_env item smarter in avoiding generic names ([#97][])

### Internal

- Updated code for Fish 3.2.0
- Refactor printing logic, much faster now ([#111][])
- Use builtin `disown` instead of function, small speed increase
- Don't even create `fish_mode_prompt` function, tiny speed improvement

### CI/Testing

- Add syntax checking for Fish
- Add format checking for Fish
- Add PHP item tests
- Add chruby item tests

## [v4.1.1][] (Feb 22 2021)

### Deprecations/Warnings

- Tide v4.1.1 will be the last version to support Fish 3.1.2

### Bug fixes

- Fixed bug where `cmd_duration` and `context` items were being removed from the user's items list
- Support `toor` and `Administrator` in context item

### Documentation

- Moved the documentation back to the Wiki
- Added an FAQ ([#96][])
- Added a Custom Items guide

## [v4.1.0][] (Feb 20 2021)

### Features

- Add `tide bug-report --clean` option for debugging
- All items are now enabled by default. Items for tools that aren't installed are automatically removed.

### Bug fixes

- Avoid parsing directories as flags ([#88][])
- Don't error if in .git directory of git repo

### CI/Testing

- Add new release action to reduce manual labor
- Add nvm, git, and time item tests
- Add truncate to unique and markers to PWD test

## [v4.0.0][] (Feb 03 2021)

### Features

- Add native git solution; 15 to 50% faster than `fish_git_prompt`.
  The `git_prompt` item has been renamed to `git`. ([#75][])
- Remove Pure style, redundant now that Tide is async ([#77][])
- Add 16 color option. Lets users customize Tide's colors through the terminal palette,
  which was one of the attractions of Pure style. ([#79][])

### Bug fixes

- Remove `seq`, fixes errors when in macOS root

### CI/Testing

- Use Littlecheck instead of Fishtape
- Test on macOS as well as Ubuntu

### Internal

- The menu code is significantly shorter
- A bunch of other small improvements, mostly because we removed `fish_git_prompt`
- Moved the resources directory into a separate repo,
  makes installing/updating Tide much faster.

## [v3.2.0][] (Jan 12 2021)

### Features

- New pwd features:
  - Markers - If a directory contains these files/directories, it will be anchored
  - Truncate to unique - Truncate directories to their shortest unique identifier, i.e no other directories match

### Bug fixes

- Fix `_tide_decolor` for linux and tmux TERMs ([#66][])
- Close stdout in background process, prompt feels super smooth now
- Ensure prompt variables are erased after uninstall ([#69][])
- Don't error if detect_os file doesn't have the specified key

## [v3.1.0][] (Dec 31 2020)

### Bug fixes

- Remove prompt cancel handling. It helped on Linux but hurt on MacOS.
- Refresh prompt when right prompt changes ([#59][])
- Set color to normal at end of prompt ([#63][] - @peng1999)
- Allow for installation into non-standard locations ([#65][] - @vamega)

## [v3.0.0][] (Dec 22 2020)

### Features

- Prompt now renders asynchronously ([#15][])
- Prompt now redraws accurately when the line is cancelled ([#53][])

## [v2.5.0][] (Nov 19 2020)

### Features

- Switched installation method to fisher
- Added an icons menu to the configuration wizard ([#20][])

### Bug fixes

- Fixed `tide install --unattended` erroring 404 ([#30][])
- Fixed tab selection menu occasionally being colorized ([#33][])
- Fixed os detection erroring if `/etc/lsb-release` did not exist ([#40][] - @Shadow53)
- Switched to `mktemp` instead of assuming that `/tmp` will exist ([#41][] - @Shadow53)
- Erase all `_tide_*` "private" functions on uninstall ([#43][] - @jorgebucaran)
- Moved `fish_right_prompt` to it's own file to prevent errors after uninstall ([#45][] - @jorgebucaran)

### Documentation

- Added a brief explanation for how to modify variables ([#29][] - @Epse)
- Fixed a broken link to the `fish_git_prompt` documentation ([#32][] - @PatrickF1)

### CI/Testing

- Minor improvements to CI
- Improved test suite
  - Added function mocking
  - Added rust item test

## [v2.4.0][] (Sep 21 2020)

### Features

- Added number of jobs option ([#5][])
- Added `nvm` item ([#23][])
- Added support for lsb-release in `detect_os` for non systemd distros ([#24][])
- Added `vi_mode` item and `prompt_char_vi` variables for vi keybindings users ([#26][])

### Bug fixes

- Added git dirty state to pure style ([#18][])
- Fixed bug when pwd started with / ([#25][])

## [v2.3.0][] (Aug 20 2020)

- Add question issue template
- Combine CI workflows
- Lots of new unit tests
- Add `context_always_display` option
- Add Rust item

## [v2.2.0][] (Aug 02 2020)

- Actions
  - Add [super-linter][] action to lint markdown and yaml.
  - Add [prettier action][] to format markdown and yaml.
- Rename `master` to `main`

## [v2.1.0][] (Jul 29 2020)

- Fix bug with `basename` on macOS
- Minor edits to README
- New `os` item
  - Displays a 1 character icon representing your os/distro
  - Falls back to a similar distro of linux if yours isn't recognized

## [v2.0.0][] (Jul 26 2020)

- Add Powerline support!
  - Item separators
  - Background colors
- Add continuous integration
- Update documentation
  - Move configuration to wiki
  - Beautify the readme

## [v1.5.0][] (Jun 28 2020)

- Many more pure prompt menus
- Add stash state to pure
- Add virtual_env item

## [v1.4.0][] (Jun 17 2020)

- Add pure support

## [v1.3.2][] (Jun 13 2020)

- Fix / not showing at start of pwd

## [v1.3.1][] (Jun 08 2020)

- Fix pwd not displaying in unwritable directories

## [v1.3.0][] (Jun 06 2020)

- Massive speed increase
  - Greater than 2x in most cases
  - Run code only when relevant variables change

## [v1.2.0][] (Jun 05 2020)

- Add pwd anchors
  - Bold directories that don't get truncated
  - Options: first, last, and git
- Add recommended font to readme
- Add contributing guide and code of conduct

## [v1.1.2][] (May 24 2020)

- Fix `tide configure` making fish_prompt larger and larger

## [v1.1.1][] (May 24 2020)

- `tide configure` now also resets fish_prompt to default

## [v1.1.0][] (May 24 2020)

- Pwd adds a second letter when truncating a directory with a dot in front
- Wizard restores default configuration of variables
- Tide command now has completions for subcommands
- Readme now uses a git.io vanity link

## [v1.0.0][] (May 20 2020)

- First release

[#5]: https://github.com/IlanCosman/tide/issues/5
[#15]: https://github.com/IlanCosman/tide/issues/15
[#18]: https://github.com/IlanCosman/tide/issues/18
[#20]: https://github.com/IlanCosman/tide/issues/20
[#23]: https://github.com/IlanCosman/tide/issues/23
[#24]: https://github.com/IlanCosman/tide/issues/24
[#25]: https://github.com/IlanCosman/tide/issues/25
[#26]: https://github.com/IlanCosman/tide/issues/26
[#29]: https://github.com/IlanCosman/tide/issues/29
[#30]: https://github.com/IlanCosman/tide/issues/30
[#32]: https://github.com/IlanCosman/tide/issues/32
[#33]: https://github.com/IlanCosman/tide/issues/33
[#40]: https://github.com/IlanCosman/tide/issues/40
[#41]: https://github.com/IlanCosman/tide/issues/41
[#43]: https://github.com/IlanCosman/tide/issues/43
[#45]: https://github.com/IlanCosman/tide/issues/45
[#53]: https://github.com/IlanCosman/tide/issues/53
[#59]: https://github.com/IlanCosman/tide/issues/59
[#63]: https://github.com/IlanCosman/tide/issues/63
[#65]: https://github.com/IlanCosman/tide/issues/65
[#66]: https://github.com/IlanCosman/tide/issues/66
[#69]: https://github.com/IlanCosman/tide/issues/69
[#75]: https://github.com/IlanCosman/tide/issues/75
[#77]: https://github.com/IlanCosman/tide/issues/77
[#79]: https://github.com/IlanCosman/tide/issues/79
[#88]: https://github.com/IlanCosman/tide/issues/88
[#91]: https://github.com/IlanCosman/tide/issues/91
[#96]: https://github.com/IlanCosman/tide/issues/96
[#97]: https://github.com/IlanCosman/tide/issues/97
[#100]: https://github.com/IlanCosman/tide/issues/100
[#105]: https://github.com/IlanCosman/tide/issues/105
[#107]: https://github.com/IlanCosman/tide/issues/107
[#111]: https://github.com/IlanCosman/tide/issues/111
[#121]: https://github.com/IlanCosman/tide/issues/121
[#126]: https://github.com/IlanCosman/tide/issues/126
[#129]: https://github.com/IlanCosman/tide/issues/129
[#130]: https://github.com/IlanCosman/tide/issues/130
[#131]: https://github.com/IlanCosman/tide/issues/131
[#134]: https://github.com/IlanCosman/tide/issues/134
[#138]: https://github.com/IlanCosman/tide/issues/138
[#139]: https://github.com/IlanCosman/tide/issues/139
[#145]: https://github.com/IlanCosman/tide/issues/145
[#154]: https://github.com/IlanCosman/tide/issues/154
[#156]: https://github.com/IlanCosman/tide/issues/156
[#157]: https://github.com/IlanCosman/tide/issues/157
[#162]: https://github.com/IlanCosman/tide/issues/162
[#163]: https://github.com/IlanCosman/tide/issues/163
[#171]: https://github.com/IlanCosman/tide/issues/171
[#174]: https://github.com/IlanCosman/tide/issues/174
[#178]: https://github.com/IlanCosman/tide/issues/178
[#181]: https://github.com/IlanCosman/tide/issues/181
[#187]: https://github.com/IlanCosman/tide/issues/187
[#203]: https://github.com/IlanCosman/tide/issues/203
[#211]: https://github.com/IlanCosman/tide/issues/211
[#220]: https://github.com/IlanCosman/tide/issues/220
[#221]: https://github.com/IlanCosman/tide/issues/221
[#231]: https://github.com/IlanCosman/tide/issues/231
[#244]: https://github.com/IlanCosman/tide/issues/244
[#250]: https://github.com/IlanCosman/tide/issues/250
[#254]: https://github.com/IlanCosman/tide/issues/254
[#271]: https://github.com/IlanCosman/tide/issues/271
[#274]: https://github.com/IlanCosman/tide/issues/274
[#277]: https://github.com/IlanCosman/tide/issues/277
[#283]: https://github.com/IlanCosman/tide/issues/283
[#288]: https://github.com/IlanCosman/tide/issues/288
[#289]: https://github.com/IlanCosman/tide/issues/289
[#290]: https://github.com/IlanCosman/tide/issues/290
[#293]: https://github.com/IlanCosman/tide/issues/293
[#295]: https://github.com/IlanCosman/tide/issues/295
[#303]: https://github.com/IlanCosman/tide/issues/303
[#305]: https://github.com/IlanCosman/tide/issues/305
[#322]: https://github.com/IlanCosman/tide/issues/322
[#323]: https://github.com/IlanCosman/tide/issues/323
[#330]: https://github.com/IlanCosman/tide/issues/330
[#335]: https://github.com/IlanCosman/tide/pull/335
[#337]: https://github.com/IlanCosman/tide/pull/337
[#343]: https://github.com/IlanCosman/tide/pull/343
[#346]: https://github.com/IlanCosman/tide/issues/346
[#373]: https://github.com/IlanCosman/tide/pull/373
[#394]: https://github.com/IlanCosman/tide/issues/394
[#398]: https://github.com/IlanCosman/tide/pull/398
[#399]: https://github.com/IlanCosman/tide/issues/399
[prettier action]: https://github.com/actionsx/prettier
[super-linter]: https://github.com/github/super-linter
[v1.0.0]: https://github.com/IlanCosman/tide/tree/v1.0.0
[v1.1.0]: https://github.com/IlanCosman/tide/tree/v1.1.0
[v1.1.1]: https://github.com/IlanCosman/tide/tree/v1.1.1
[v1.1.2]: https://github.com/IlanCosman/tide/tree/v1.1.2
[v1.2.0]: https://github.com/IlanCosman/tide/tree/v1.2.0
[v1.3.0]: https://github.com/IlanCosman/tide/tree/v1.3.0
[v1.3.1]: https://github.com/IlanCosman/tide/tree/v1.3.1
[v1.3.2]: https://github.com/IlanCosman/tide/tree/v1.3.2
[v1.4.0]: https://github.com/IlanCosman/tide/tree/v1.4.0
[v1.5.0]: https://github.com/IlanCosman/tide/tree/v1.5.0
[v2.0.0]: https://github.com/IlanCosman/tide/tree/v2.0.0
[v2.1.0]: https://github.com/IlanCosman/tide/tree/v2.1.0
[v2.2.0]: https://github.com/IlanCosman/tide/tree/v2.2.0
[v2.3.0]: https://github.com/IlanCosman/tide/tree/v2.3.0
[v2.4.0]: https://github.com/IlanCosman/tide/tree/v2.4.0
[v2.5.0]: https://github.com/IlanCosman/tide/tree/v2.5.0
[v3.0.0]: https://github.com/IlanCosman/tide/tree/v3.0.0
[v3.1.0]: https://github.com/IlanCosman/tide/tree/v3.1.0
[v3.2.0]: https://github.com/IlanCosman/tide/tree/v3.2.0
[v4.0.0]: https://github.com/IlanCosman/tide/tree/v4.0.0
[v4.1.0]: https://github.com/IlanCosman/tide/tree/v4.1.0
[v4.1.1]: https://github.com/IlanCosman/tide/tree/v4.1.1
[v4.2.0]: https://github.com/IlanCosman/tide/tree/v4.2.0
[v4.3.0]: https://github.com/IlanCosman/tide/tree/v4.3.0
[v4.3.1]: https://github.com/IlanCosman/tide/tree/v4.3.1
[v4.3.2]: https://github.com/IlanCosman/tide/tree/v4.3.2
[v4.3.3]: https://github.com/IlanCosman/tide/tree/v4.3.3
[v4.3.4]: https://github.com/IlanCosman/tide/tree/v4.3.4
[v5.0.0]: https://github.com/IlanCosman/tide/tree/v5.0.0
[v5.0.1]: https://github.com/IlanCosman/tide/tree/v5.0.1
[v5.1.0]: https://github.com/IlanCosman/tide/tree/v5.1.0
[v5.1.1]: https://github.com/IlanCosman/tide/tree/v5.1.1
[v5.1.2]: https://github.com/IlanCosman/tide/tree/v5.1.2
[v5.2.0]: https://github.com/IlanCosman/tide/tree/v5.2.0
[v5.2.1]: https://github.com/IlanCosman/tide/tree/v5.2.1
[v5.2.2]: https://github.com/IlanCosman/tide/tree/v5.2.2
[v5.3.0]: https://github.com/IlanCosman/tide/tree/v5.3.0
[v5.4.0]: https://github.com/IlanCosman/tide/tree/v5.4.0
[v5.5.0]: https://github.com/IlanCosman/tide/tree/v5.5.0
[v5.5.1]: https://github.com/IlanCosman/tide/tree/v5.5.1
[v5.6.0]: https://github.com/IlanCosman/tide/tree/v5.6.0
[v6.0.0]: https://github.com/IlanCosman/tide/tree/v6.0.0
[v6.0.1]: https://github.com/IlanCosman/tide/tree/v6.0.1
