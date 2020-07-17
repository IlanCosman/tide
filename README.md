# 🌊 Tide [![ci_badge][]][actions] [![fish_version_badge][]](#System-Requirements) [![license_badge][]][license]

Tide is a [Fish][] theme that provides a powerful, flexible, and out-of-the-box experience.

![prompt_connection][]

## Installation

1. Install the [recommended font](#Fonts). _Optional but highly recommended_

2. Source and run the install function:

   ```console
   curl -sL git.io/tide | source && tide_install
   ```

### System Requirements

- [fish][] ≥3.1
- [git][]

## Features

### Configuration Wizard

Type `tide configure` to open the the wizard in your terminal.

![configuration_wizard][]

### Multi-Line Right Prompt

> Fish can't do _that_ yet can it?

![multi-line_right_prompt][]

### Pure Compatibility

Tide can produce the same prompt as [Pure][]. Type `tide configure` and select the Pure style.

![pure_compatibility][]

Tide doesn't recognize Pure configuration parameters, so you'll need to use `set tide_cmd_duration_threshold 3000` instead of `set pure_threshold_command_duration 3`, etc.

Pure style is an exact replication of the Pure fish theme and therefore displays less information than Lean. It exists only to ease the migration for users of that theme. Unless you are one of them, choose Lean style over Pure.

### Extensible

If there isn't a prompt item that fits your needs, make your own!

![extensible][]

## Contributing

If you're interested in helping contribute to Tide, please take a look at the [Contributing Guide][].

## Configuration

Tide variables that users are encouraged to modify begin with the string `tide_`. Thus, variables in this section will be denoted as `example_variable` but will actually be `tide_example_variable`.

## General Variables

| Variable           | Description                                | Default                                      |
| ------------------ | ------------------------------------------ | -------------------------------------------- |
| newline            | add empty line before each prompt          | true                                         |
| left_prompt_items  | order of the left prompt items to display  | pwd git_prompt newline prompt_char           |
| right_prompt_items | order of the right prompt items to display | status cmd_duration context jobs virtual_env |

### prompt_connection

| Variable                | Description                                                           | Default |
| ----------------------- | --------------------------------------------------------------------- | ------- |
| prompt_connection_color | color of prompt connection                                            | 6C6C6C  |
| prompt_connection_icon  | repeated symbol that spans gap between left and right sides of prompt | ' '     |

## Prompt Items

| Item                          | Description                      |
| ----------------------------- | -------------------------------- |
| [cmd_duration](#cmd_duration) | duration of the last run command |
| [context](#context)           | user@hostname in ssh or root     |
| [git_prompt](#git_prompt)     | git repository status            |
| [jobs](#jobs)                 | presence of background jobs      |
| [prompt_char](#prompt_char)   | prompt symbol;turns red on error |
| [pwd](#pwd)                   | current directory                |
| [status](#status)             | exit code of the last command    |
| [time](#time)                 | current time                     |
| [virtual_env](#virtual_env)   | python virtual environment       |

### cmd_duration

| Variable               | Description                                                        | Default |
| ---------------------- | ------------------------------------------------------------------ | ------- |
| cmd_duration_color     | color of cmd_duration output                                       | 87875F  |
| cmd_duration_decimals  | number of decimals to display after seconds place                  | 0       |
| cmd_duration_threshold | number of milliseconds that duration must exceed to produce output | 3000    |

### context

| Variable           | Description                     | Default |
| ------------------ | ------------------------------- | ------- |
| context_root_color | color of context when root user | D7AF00  |
| context_ssh_color  | color of context when in SSH    | D7AF87  |

### git_prompt

Tide's git capabilities are inherited from fish's built-in [fish_git_prompt][]. Modify those variables to configure tide's git prompt.

### jobs

| Variable   | Description                                      | Default |
| ---------- | ------------------------------------------------ | ------- |
| jobs_color | color of jobs icon                               | D7AF00  |
| jobs_icon  | symbol to display when there are background jobs | ''     |

### prompt_char

| Variable                  | Description                                           | Default |
| ------------------------- | ----------------------------------------------------- | ------- |
| prompt_char_icon          | prompt char symbol                                    | '❯'     |
| prompt_char_success_color | color of prompt char when last command was successful | 5FD700  |
| prompt_char_failure_color | color of prompt char when last command failed         | FF0000  |

### pwd

| Variable                 | Description                                                       | Default              |
| ------------------------ | ----------------------------------------------------------------- | -------------------- |
| pwd_anchors              | Directories displayed in bold and immune to truncation            | 'first' 'last' 'git' |
| pwd_color_anchors        | color of anchors                                                  | 00AFFF               |
| pwd_truncate_margin      | start truncating when pwd is this many columns from terminal edge | 10                   |
| pwd_color_truncated_dirs | color of truncated directories                                    | 8787AF               |
| pwd_max_dirs             | max number of directories to display, 0 or less equals unlimited  | 0                    |
| pwd_color_dirs           | color of normal directories                                       | 0087AF               |
| pwd_unwritable_icon      | symbol to display when the directory is not writable by the user  | ''                  |

### status

| Variable             | Description                                                    | Default |
| -------------------- | -------------------------------------------------------------- | ------- |
| status_success_icon  | symbol to display when the last command in a pipeline succeeds | '✔'     |
| status_success_color | color of successful pipeline's status                          | 5FAF00  |
| status_failure_icon  | symbol to display when the last command in a pipeline fails    | '✘'     |
| status_failure_color | color of failed pipeline's status                              | D70000  |

### time

| Variable    | Description            | Default |
| ----------- | ---------------------- | ------- |
| time_color  | color of time display  | 5F8787  |
| time_format | format of time display | '%T'    |

### virtual_env

| Variable            | Description                                                                                                                            | Default     |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| virtual_env_color   | color of virtual_env item                                                                                                              | 00AFAF      |
| virtual_env_icon    | icon to display in front of virtual_env item                                                                                           | ''         |
| virtual_env_display | Options are venvName and projectName. venvName is the virtual env directory, most often .venv. projectName is the directory above that | projectName |

## Fonts

### Meslo Nerd Font

Gorgeous monospace font designed by Jim Lyles for Bitstream, customized for Apple, enhanced by André Berg, and finally patched by Roman Perepelitsa of [Powerlevel10k][] with scripts originally developed by Ryan L McIntyre of [Nerd Fonts][]. Contains all the glyphs and symbols that Tide may need. Battle-tested in dozens of different terminals on all major operating systems.

### Font Installation

Download these four ttf files:

- [MesloLGS NF Regular.ttf][]
- [MesloLGS NF Bold.ttf][]
- [MesloLGS NF Italic.ttf][]
- [MesloLGS NF Bold Italic.ttf][]

Open each file and click "Install". This will make the `MesloLGS NF` font available to all applications on your system. Configure your terminal to use this font.

## Acknowledgments

- [Powerlevel10k][] - Much of Tide's documentation, resources, ideas, and design elements are borrowed from Powerlevel10k.

<!-- Alphabetical Reference Links -->

[actions]: https://github.com/IlanCosman/tide/actions
[ci_badge]: https://github.com/IlanCosman/tide/workflows/CI/badge.svg
[configuration_wizard]: https://github.com/IlanCosman/tide/wiki/resources/svgs/Configuration_Wizard.svg
[contributing guide]: CONTRIBUTING.md
[extensible]: https://github.com/IlanCosman/tide/wiki/resources/images/Extensible.png
[fish]: https://github.com/fish-shell/fish-shell
[fish_git_prompt]: https://fishshell.com/docs/current/cmds/fish_git_prompt.html
[fish_version_badge]: https://img.shields.io/badge/fish-3.1.0%2B-blue
[git]: https://github.com/git/git
[license]: LICENSE.md
[license_badge]: https://img.shields.io/github/license/IlanCosman/tide
[meslolgs nf bold.ttf]: https://github.com/IlanCosman/tide/wiki/resources/fonts/MesloLGS%20NF%20Bold.ttf
[meslolgs nf bold italic.ttf]: https://github.com/IlanCosman/tide/wiki/resources/fonts/MesloLGS%20NF%20Bold%20Italic.ttf
[meslolgs nf italic.ttf]: https://github.com/IlanCosman/tide/wiki/resources/fonts/MesloLGS%20NF%20Italic.ttf
[meslolgs nf regular.ttf]: https://github.com/IlanCosman/tide/wiki/resources/fonts/MesloLGS%20NF%20Regular.ttf
[multi-line_right_prompt]: https://github.com/IlanCosman/tide/wiki/resources/images/Multi-Line_Right_Prompt.png
[nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[powerlevel10k]: https://github.com/romkatv/powerlevel10k/
[prompt_connection]: https://github.com/IlanCosman/tide/wiki/resources/images/Prompt_Connection.png
[pure]: https://github.com/rafaelrinaldi/pure
[pure_compatibility]: https://github.com/IlanCosman/tide/wiki/resources/svgs/Pure_Compatibility.svg
