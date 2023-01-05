<div align="center">

<img src="../assets/images/logo.svg" width="61.8%"/><br>

[![ci_badge][]][actions] ​ [![license_badge][]][license] ​ [![blazing_badge][]][blazing_tweet] <!-- 0 width spaces on this line -->

</div>

#

<img src="../assets/images/header.png" width="50%" align="right"/>

**The ultimate Fish prompt.**

- **Out of the box:** With three compelling styles and lots of options, you can have your ready-to-run cake and customize it too.
- **Flexible:** Move content around or remove it, all without ever touching a line of code.
- **Extensible:** Create custom content with simple Fish functions that integrate seamlessly.
- **Fast:** Asynchronous rendering makes Tide the fastest full-featured Fish prompt.

<br clear="right">

## Installation

### System Requirements

- The **latest** version of [Fish][], currently 3.5.1. <sub>[Using an older version of Fish?][]</sub>
- A [Nerd Font][nerd fonts] installed and enabled in your terminal (for example the [recommended font](#fonts)).
- A [Git][git], version >=2.22

Install with [Fisher][]:

```console
fisher install IlanCosman/tide@v5
```

<details>
  <summary>Install manually</summary>

This script may not work for all use cases.

```fish
set -l _tide_tmp_dir (command mktemp -d)
curl https://codeload.github.com/ilancosman/tide/tar.gz/v5 | tar -xzC $_tide_tmp_dir
command cp -R $_tide_tmp_dir/*/{completions,conf.d,functions} $__fish_config_dir
fish_path=(status fish-path) exec $fish_path -C "emit _tide_init_install"
```

</details>

## Features

### Configuration Wizard

Run `tide configure` to open the wizard in your terminal.

![configuration_wizard][]

<br>

<img src="../assets/images/extensible.png" width="61.8%" align="right"/>

### Extensible

If there isn't an item that fits your needs you can make your own (and hopefully submit a pull request) or ask for it to be made by opening an issue.

<br clear="right"><br>

<img src="../assets/images/flexible.png" width="61.8%" align="left"/>

### Flexible

Using the [`items`][] list for each side of the prompt, you have full control of which and where prompt sections display.

<br clear="left"><br>

### Asynchronous Rendering

Tide runs everything in the background so that your prompt will always feel snappy.

![async][]

Asynchronous rendering also allows Tide to display more information than other prompts. For example, most prompts don't display the number of untracked, modified, or deleted files in a git repository because it's too slow to compute.

<br>

<img src="../assets/images/multi-line_right_prompt.png" width="61.8%" align="left"/>

### Multi-Line Right Prompt

> Fish can't do _that_ yet can it!

Tide is the only Fish prompt capable of displaying a multi-line right prompt. All you have to do is add the `newline` item.

<br clear="left">

### Current directory that just works

The current working directory is the most important part of any shell prompt. Tide highlights the critical parts and truncates with the least loss of information when horizontal space is scarce.

![pwd][]

When the full directory doesn't fit, the leftmost segment is truncated to its shortest unique prefix. In the example above, `Documents` becomes `Doc` instead of `D` because that could be confused with `Downloads`. Important segments are bold and never truncated. These include the last segment, root of a Git repository etc.

<sup>_Tip_: If you copy-paste a truncated path and hit <kbd>tab</kbd>, it will complete to the original.</sup>

## Documentation

See the [Wiki][] for documentation.

## Contributing

From the smallest typo to the largest feature, contributions of any size or experience level are welcome!

If you're interested in helping contribute to Tide, please take a look at the [Contributing Guide][].

## Fonts

### Meslo Nerd Font

A gorgeous monospace font designed by Jim Lyles for Bitstream, customized for Apple, enhanced by André Berg, and finally patched by Roman Perepelitsa of [Powerlevel10k][] with scripts originally developed by Ryan McIntyre of [Nerd Fonts][]. Contains all the glyphs and symbols that Tide may need. Battle-tested in dozens of different terminals on all major operating systems.

### Font Installation

Download these four ttf files:

- [MesloLGS NF Regular.ttf][]
- [MesloLGS NF Bold.ttf][]
- [MesloLGS NF Italic.ttf][]
- [MesloLGS NF Bold Italic.ttf][]

Open each file and click "Install". This will make the `MesloLGS NF` font available to all applications on your system. Configure your terminal to use this font.

## Acknowledgments

- [Powerlevel10k][] - Inspired Tide's creation. Because Tide aims to replicate Powerlevel10k's amazing capabilities, small sections of documentation have been borrowed when rewording the language would reduce clarity.
- [Starship][] - Inspired elements of Tide's documentation and community health files.
- [Spacefish][] - Inspired some of Tide's items.

[`items`]: https://github.com/IlanCosman/tide/wiki/Configuration#items
[actions]: https://github.com/IlanCosman/tide/actions
[async]: ../assets/animations/async.gif
[blazing_badge]: https://img.shields.io/badge/speed-blazing%20%F0%9F%94%A5-red
[blazing_tweet]: https://twitter.com/acdlite/status/974390255393505280
[ci_badge]: https://github.com/IlanCosman/tide/workflows/CI/badge.svg
[configuration_wizard]: ../assets/animations/configuration_wizard.gif
[contributing guide]: CONTRIBUTING.md
[fish]: https://fishshell.com/
[fisher]: https://github.com/jorgebucaran/fisher
[git]: https://git-scm.com
[license_badge]: https://img.shields.io/github/license/IlanCosman/tide
[license]: LICENSE.md
[meslolgs nf bold italic.ttf]: ../assets/fonts/mesloLGS_NF_bold_italic.ttf?raw=true
[meslolgs nf bold.ttf]: ../assets/fonts/mesloLGS_NF_bold.ttf?raw=true
[meslolgs nf italic.ttf]: ../assets/fonts/mesloLGS_NF_italic.ttf?raw=true
[meslolgs nf regular.ttf]: ../assets/fonts/mesloLGS_NF_regular.ttf?raw=true
[nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[powerlevel10k]: https://github.com/romkatv/powerlevel10k/
[pwd]: ../assets/images/pwd.png
[spacefish]: https://github.com/matchai/spacefish
[starship]: https://github.com/starship/starship
[using an older version of fish?]: https://github.com/IlanCosman/tide/wiki/Fish-version-compatibility
[wiki]: https://github.com/IlanCosman/tide/wiki
