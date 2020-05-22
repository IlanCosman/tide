# Tide ![Fish_Version_Shield](https://img.shields.io/badge/fish-3.1.0-blue)

Tide is a Fish theme inspired by [Powerlevel10k](https://github.com/romkatv/powerlevel10k/). It aims to provide a powerful, flexible, and out-of-the-box experience.

![Prompt_Connection](/media/images/Prompt_Connection.png)

# Installation

Source and run the install function:

```fish
curl -sL git.io/tide-fish | source; and tide_install
```

# Features

### Multi-Line Right Prompt

> Fish cant do _that_ yet can it?

![Multi-Line_Right_Prompt](/media/images/Multi-Line_Right_Prompt.png)

### Configuration Wizard

Type `tide configure` to open the the wizard in your terminal.

![Configuration_Wizard](/media/gifs/Configuration_Wizard.gif)

### Extensible

If there isn't a prompt item that fits your needs, make your own!

![Extensible](/media/images/Extensible.png)

# Configuration

Tide variables that users are encouraged to modify begin with the string `tide_`. Thus, variables in this section will be denoted as `example_variable` but will actually be `tide_example_variable`.

## General Variables

| Variable           | Description                                | Default                                    |
| ------------------ | ------------------------------------------ | ------------------------------------------ |
| newline            | add empty line before each prompt          | true                                       |
| left_prompt_items  | order of the left prompt items to display  | 'pwd' 'git_prompt' 'newline' 'prompt_char' |
| right_prompt_items | order of the right prompt items to display | 'status' 'cmd_duration' 'context' 'jobs'   |

### prompt connection

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

Tide's git capabilities are inherited from fish's built-in [fish_git_prompt](https://fishshell.com/docs/current/cmds/fish_git_prompt.html). Modify those variables to configure tide's git prompt.

### jobs

| Variable   | Description                                      | Default |
| ---------- | ------------------------------------------------ | ------- |
| jobs_color | color of jobs icon                               | D7AF00  |
| jobs_icon  | symbol to display when there are background jobs | D7AF87  |

### prompt_char

| Variable                  | Description                                           | Default |
| ------------------------- | ----------------------------------------------------- | ------- |
| prompt_char_icon          | prompt char symbol                                    | '❯'     |
| prompt_char_success_color | color of prompt char when last command was successful | 5FD700  |
| prompt_char_failure_color | color of prompt char when last command failed         | FF0000  |

### pwd

| Variable                 | Description                                                              | Default        |
| ------------------------ | ------------------------------------------------------------------------ | -------------- |
| pwd_truncate_margin      | number of columns distance to maintain between pwd and edge of terminal  | 5              |
| pwd_unwritable_icon      | symbol to display when the current directory is not writable by the user | '' #Lock icon |
| pwd_color_end_dirs       | color of first and last directories                                      | 00AFFF         |
| pwd_color_mid_dirs       | color of directories between first and last                              | 0087AF         |
| pwd_color_truncated_dirs | color of directories that get truncated when pwd is too long             | 8787AF         |

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
