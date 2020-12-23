# Changelog

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
