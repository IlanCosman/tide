# Configuration

The following sections contain tables of variable names, their descriptions, and their types, organized alphabetically.

| Type    | Description                                |
| ------- | ------------------------------------------ |
| boolean | string `true` or `false`                   |
| color   | argument that [`set_color`][] would accept |
| integer | number without decimals                    |
| list    | collection of other types                  |
| string  | sequence of characters                     |

Variables in these sections will be denoted as `foo_bar` but will actually be `tide_<INSERT HEADER>_foo_bar`. Variables that do not conform to this standard will be written out in full.

You can take a look at the default configurations in `~/.config/fish/functions/tide/configure/configs` for inspiration.

You can modify variables using `set --universal` from the command line or `set --global` in your `config.fish` file.

## Prompt Variables

| Variable                         | Description                           | Type    |
| -------------------------------- | ------------------------------------- | ------- |
| tide_print_newline_before_prompt | print an empty line before the prompt | boolean |

### prompt_connection

| Variable | Description                                                           | Type   |
| -------- | --------------------------------------------------------------------- | ------ |
| color    | color of prompt connection                                            | color  |
| icon     | repeated symbol that spans gap between left and right sides of prompt | string |

### left_prompt

| Variable                        | Description                                               | Type    |
| ------------------------------- | --------------------------------------------------------- | ------- |
| frame_color                     | color of the left prompt frame                            | color   |
| frame_enabled                   | display the left prompt frame                             | boolean |
| item_separator_diff_color       | string to separate items with different background colors | string  |
| item_separator_same_color       | string to separate items with the same background color   | string  |
| item_separator_same_color_color | color of the item_separator_same_color                    | color   |
| items                           | order of items to print in the left prompt                | list    |
| pad_items                       | add spaces to the ends of each item                       | boolean |
| prefix                          | string to put before the left prompt                      | string  |
| suffix                          | string to put after the left prompt                       | string  |

### right_prompt

| Variable                        | Description                                               | Type    |
| ------------------------------- | --------------------------------------------------------- | ------- |
| frame_color                     | color of the right prompt frame                           | color   |
| frame_enabled                   | display the right prompt frame                            | boolean |
| item_separator_diff_color       | string to separate items with different background colors | string  |
| item_separator_same_color       | string to separate items with the same background color   | string  |
| item_separator_same_color_color | color of the item_separator_same_color                    | color   |
| items                           | order of items to print in the right prompt               | list    |
| pad_items                       | add spaces to the ends of each item                       | boolean |
| prefix                          | string to put before the right prompt                     | string  |
| suffix                          | string to put after the right prompt                      | string  |

## Items

These can be added to `tide_left_prompt_items` or `tide_right_prompt_items`. For example, to add `context` to the far left of your left prompt:

```console
set --universal tide_left_prompt_items context $tide_left_prompt_items
```

| Item                          | Description                       |
| ----------------------------- | --------------------------------- |
| [cmd_duration](#cmd_duration) | duration of the last run command  |
| [context](#context)           | user@hostname in ssh or root      |
| [git](#git)                   | git repository status             |
| [jobs](#jobs)                 | presence of background jobs       |
| [nvm](#nvm)                   | node version manager              |
| [os](#os)                     | current operating system          |
| [prompt_char](#prompt_char)   | prompt symbol; turns red on error |
| [pwd](#pwd)                   | current directory                 |
| [ruby](#ruby)                 | ruby version number               |
| [rust](#rust)                 | rust version number               |
| [status](#status)             | exit code of the last command     |
| [time](#time)                 | current time                      |
| [vi_mode](#vi_mode)           | vi bind mode display              |
| [virtual_env](#virtual_env)   | python virtual environment        |
| newline                       | new line                          |

## cmd_duration

| Variable  | Description                                                        | Type    |
| --------- | ------------------------------------------------------------------ | ------- |
| bg_color  | background color of the cmd_duration item                          | color   |
| color     | color of the cmd_duration item                                     | color   |
| decimals  | number of decimals to display after the seconds place              | integer |
| threshold | number of milliseconds that duration must exceed to produce output | integer |

## context

| Variable       | Description                                            | Type    |
| -------------- | ------------------------------------------------------ | ------- |
| always_display | display context when not in SSH or root user           | boolean |
| bg_color       | background color of the context item                   | color   |
| default_color  | color of the context item when not in SSH or root user | color   |
| root_color     | color of the context item when the user is root        | color   |
| ssh_color      | color of the context item when in SSH                  | color   |

## git

| Variable         | Description                            | Type  |
| ---------------- | -------------------------------------- | ----- |
| bg_color         | background color of the git_item       | color |
| branch_color     | color of branch/SHA                    | color |
| conflicted_color | color of conflicted files number       | color |
| dirty_color      | color of dirty files number            | color |
| operation_color  | color of the current operation         | color |
| staged_color     | color of staged files number           | color |
| stash_color      | color of stashes number                | color |
| untracked_color  | color of untracked files number        | color |
| upstream_color   | color of upstream behind/ahead numbers | color |

## jobs

| Variable | Description                                      | Type    |
| -------- | ------------------------------------------------ | ------- |
| bg_color | background color of jobs item                    | color   |
| color    | color of jobs item                               | color   |
| icon     | string to display when there are background jobs | string  |
| verbose  | print number of jobs                             | boolean |

## nvm

| Variable | Description                  | Type   |
| -------- | ---------------------------- | ------ |
| bg_color | background color of nvm item | color  |
| color    | color of nvm item            | color  |
| icon     | icon for the nvm item        | string |

## os

| Variable | Description                 | Type  |
| -------- | --------------------------- | ----- |
| bg_color | background color of os item | color |
| color    | color of os item            | color |

## prompt_char

| Variable        | Description                                            | Type   |
| --------------- | ------------------------------------------------------ | ------ |
| bg_color        | background color of prompt_char item                   | color  |
| failure_color   | color when the last command exited with a code >0      | color  |
| icon            | icon for prompt_char to display                        | string |
| success_color   | color when the last command completed with a code of 0 | color  |
| vi_default_icon | vi default bind mode icon                              | string |
| vi_insert_icon  | vi insert bind mode icon                               | string |
| vi_replace_icon | vi replace bind mode icon                              | string |
| vi_visual_icon  | vi visual bind mode icon                               | string |

## pwd

| Variable             | Description                                                                            | Type    |
| -------------------- | -------------------------------------------------------------------------------------- | ------- |
| anchors              | directories displayed in bold and immune to truncation. Can contain `first` and `last` | list    |
| bg_color             | background color of pwd item                                                           | color   |
| color_anchors        | color of anchor directories                                                            | color   |
| color_dirs           | color of normal directories                                                            | color   |
| color_truncated_dirs | color of truncated directories                                                         | color   |
| markers              | if a directory contains any of these files/directories, it will be anchored            | list    |
| truncate_margin      | start truncating when pwd is this many columns from terminal edge                      | integer |
| unwritable_icon      | symbol to display when the directory is not writable by the user                       | string  |

## ruby

| Variable        | Description                                             | Type    |
| --------------- | ------------------------------------------------------- | ------- |
| bg_color        | background color of ruby item                           | color   |
| color           | color of ruby item                                      | color   |
| icon            | icon to display next to the ruby version                | string  |
| verbose_version | Cut off patch number from version. "3.0.0p0" vs "3.0.0" | boolean |

## rust

| Variable        | Description                                                 | Type    |
| --------------- | ----------------------------------------------------------- | ------- |
| bg_color        | background color of rust item                               | color   |
| color           | color of rust item                                          | color   |
| icon            | icon to display next to the rust version                    | string  |
| verbose_version | Cut off -suffixes from version. "v1.30.0-beta" vs "v1.30.0" | boolean |

## status

| Variable       | Description                                                     | Type    |
| -------------- | --------------------------------------------------------------- | ------- |
| always_display | display the status regardless of success or simple failure      | boolean |
| failure_color  | color of failed status                                          | color   |
| failure_icon   | symbol to display when the last command failed >1               | string  |
| success_color  | color of successful status                                      | color   |
| success_icon   | symbol to display when the last command in a pipeline succeeded | string  |

## time

| Variable | Description         | Type   |
| -------- | ------------------- | ------ |
| color    | color of time item  | color  |
| format   | format of time item | string |

## vi_mode

| Variable         | Description                        | Type   |
| ---------------- | ---------------------------------- | ------ |
| default_bg_color | default bind mode background color | color  |
| default_color    | default bind mode color            | color  |
| default_icon     | default bind mode icon             | string |
| insert_bg_color  | insert bind mode background color  | color  |
| insert_color     | insert bind mode color             | color  |
| insert_icon      | insert bind mode icon              | string |
| replace_bg_color | replace bind mode background color | color  |
| replace_color    | replace bind mode color            | color  |
| replace_icon     | replace bind mode icon             | string |
| visual_bg_color  | visual bind mode background color  | color  |
| visual_color     | visual bind mode color             | color  |
| visual_icon      | visual bind mode icon              | string |

## virtual_env

| Variable     | Description                                                                                                                            | Type   |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| color        | color of virtual_env item                                                                                                              | color  |
| display_mode | Options are venvName and projectName. venvName is the virtual env directory, most often .venv. projectName is the directory above that | string |
| icon         | icon to display in front of virtual_env item                                                                                           | string |

[`set_color`]: https://fishshell.com/docs/current/cmds/set_color.html
