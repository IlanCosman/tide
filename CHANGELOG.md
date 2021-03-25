# Changelog

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
[#107]: https://github.com/IlanCosman/tide/issues/107
[#111]: https://github.com/IlanCosman/tide/issues/111
[#121]: https://github.com/IlanCosman/tide/issues/121
[#129]: https://github.com/IlanCosman/tide/issues/129
[#130]: https://github.com/IlanCosman/tide/issues/130
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
