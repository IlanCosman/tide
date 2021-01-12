<div align="center">

<img
   src="resources/images/logo.svg"
   alt="logo.svg"
   width="61.8%"
/>

[![ci_badge][]][actions] ​ [![fish_version_badge][]](#System-Requirements) ​ [![license_badge][]][license] <!-- 0 width spaces on this line -->

</div>

#

<img
   src="resources/images/header.png"
   alt="header.png"
   width="50%"
   align="right"
/>

**The ultimate Fish prompt.**

- **Out of the box:** With four compelling styles and lots of options, you can have your ready-to-run cake and customize it too.
- **Flexible:** Move content around or remove it, all without ever touching a line of code.
- **Extensible:** Create custom content with simple fish functions that integrate seamlessly.
- **Fast:** Asynchronous rendering makes Tide the fastest full-featured fish prompt.

<br clear="right">

## Installation

### System Requirements

- [Git][]
- [Fish][] ≥ 3.1
- A [Nerd Font][nerd fonts] installed and enabled in your terminal (for example the [recommended font](#fonts)).

Install with [Fisher][]:

```console
fisher install IlanCosman/tide
```

## Features

### Configuration Wizard

Run `tide configure` to open the the wizard in your terminal.

![configuration_wizard][]

<br>

<img
   src="resources/images/extensible.png"
   alt="extensible.png"
   width="61.8%"
   align="right"
/>

### Extensible

If there isn't an item that fits your needs you can make your own (and hopefully submit a pull request) or ask for it to be made by opening an issue.

<br clear="right"><br>

<img
   src="resources/images/flexible.png"
   alt="flexible.png"
   width="61.8%"
   align="left"
/>

### Flexible

Using the [`items`][] list for each side of the prompt, you have full control of which and where prompt sections display.

<br clear="left"><br>

### Asynchronous Rendering

Tide runs everything in the background so that your prompt will always feel snappy.

![async][]

Asynchronous rendering also allows Tide to display more information than other prompts. For example, most prompts don't display the number of untracked, modified, or deleted files in a git repository because it's too slow to compute.

<br>

<img
   src="resources/images/multi-line_right_prompt.png"
   alt="multi-line_right_prompt.png"
   width="61.8%"
   align="left"
/>

### Multi-Line Right Prompt

> Fish can't do _that_ yet can it!

Tide is the only Fish prompt capable of displaying a multi-line right prompt. All you have to do is add the `newline` item.

<br clear="left"><br>

### Current directory that just works

The current working directory is the the most important part of any shell prompt. Tide highlights the critical parts and truncates with the least loss of information when horizontal space is scarce.

![pwd][]

When the full directory doesn't fit, the leftmost segment is truncated to its shortest unique prefix. For example, `~/Documents` becomes `~/Doc` instead of `~/D` because that could be confused with `~/Downloads`. Important segments are bold and never truncated. These include the first and the last segments, roots of Git repositories etc.

<small>_Tip_: If you copy-paste a truncated directory and hit <kbd>tab</kbd>, it will complete to the original.</small>_

## Configuration

See the [configuration guide][] for variable documentation.

## Contributing

From the smallest typo to the largest feature, contributions of any size or experience level are welcome!

If you're interested in helping contribute to Tide, please take a look at the [Contributing Guide][].

## Fonts

### Meslo Nerd Font

Gorgeous monospace font designed by Jim Lyles for Bitstream, customized for Apple, enhanced by André Berg, and finally patched by Roman Perepelitsa of [Powerlevel10k][] with scripts originally developed by Ryan McIntyre of [Nerd Fonts][]. Contains all the glyphs and symbols that Tide may need. Battle-tested in dozens of different terminals on all major operating systems.

### Font Installation

Download these four ttf files:

- [MesloLGS NF Regular.ttf][]
- [MesloLGS NF Bold.ttf][]
- [MesloLGS NF Italic.ttf][]
- [MesloLGS NF Bold Italic.ttf][]

Open each file and click "Install". This will make the `MesloLGS NF` font available to all applications on your system. Configure your terminal to use this font.

## Acknowledgments

- [Powerlevel10k][] - Inspired much of Tide's documentation, resources, ideas, and design.
- [Starship][] - Inspired elements of Tide's documentation and community health files.
- [Spacefish][] - Inspired some of Tide's items.

[`items`]: docs/Configuration.md#Items
[actions]: https://github.com/IlanCosman/tide/actions
[async]: resources/animations/async.gif
[ci_badge]: https://github.com/IlanCosman/tide/workflows/CI/badge.svg
[configuration guide]: docs/Configuration.md
[configuration_wizard]: resources/animations/configuration_wizard.gif
[contributing guide]: CONTRIBUTING.md
[fish_version_badge]: https://img.shields.io/badge/fish-3.1.0%2B-blue
[fish]: https://fishshell.com/
[fisher]: https://github.com/jorgebucaran/fisher
[git]: https://git-scm.com/
[license_badge]: https://img.shields.io/github/license/IlanCosman/tide
[license]: LICENSE.md
[meslolgs nf bold italic.ttf]: https://github.com/IlanCosman/tide/raw/main/resources/fonts/mesloLGS_NF_bold_italic.ttf
[meslolgs nf bold.ttf]: https://github.com/IlanCosman/tide/raw/main/resources/fonts/mesloLGS_NF_bold.ttf
[meslolgs nf italic.ttf]: https://github.com/IlanCosman/tide/raw/main/resources/fonts/mesloLGS_NF_italic.ttf
[meslolgs nf regular.ttf]: https://github.com/IlanCosman/tide/raw/main/resources/fonts/mesloLGS_NF_regular.ttf
[nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[powerlevel10k]: https://github.com/romkatv/powerlevel10k/
[pure]: https://github.com/rafaelrinaldi/pure
[pwd]: resources/images/pwd.png
[spacefish]: https://github.com/matchai/spacefish
[starship]: https://github.com/starship/starship
