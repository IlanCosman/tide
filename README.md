# Tide ![Fish_Version_Shield](https://img.shields.io/badge/fish-3.1.0-blue)

A Fish theme based on [Powerlevel10k](https://github.com/romkatv/powerlevel10k/).

![Prompt_Connection](/media/images/Prompt_Connection.png)

# Installation

Run the install script:

```fish
curl -s https://raw.githubusercontent.com/IlanCosman/tide/master/install.fish | source; and tide_install
```

# Features

- Reactive superior prompt character `❯`
- Current directory, shortened according to terminal width
- Git branch and status information
- Configuration wizard
- Right Prompt Items:

|     Item     | Display                               |
| :----------: | ------------------------------------- |
|    status    | special exit statuses and pipe status |
| cmd_duration | duration of the last run command      |
|   context    | user@hostname when using SSH or root  |
|     jobs     | presence of background jobs           |
|     time     | current time                          |

# Configuration

Note that all tide variables, unless stated otherwise, begin with the string `tide_`. Thus, for brevity, variables in this section will be denoted as `example_variable` but will actually be `tide_example_variable`.

## Prompt Items

### pwd

| Variable            | Description                                                              | Default        |
| ------------------- | ------------------------------------------------------------------------ | -------------- |
| pwd_shorten_margin  | number of columns distance to maintain between pwd and edge of terminal  | 5              |
| pwd_unwritable_icon | symbol to display when the current directory is not writable by the user | '' #Lock icon |

### git prompt

Tide's git capabilities are inherited from fish's built-in [fish_git_prompt](https://fishshell.com/docs/current/cmds/fish_git_prompt.html). Modify those variables to configure tide's git prompt.

### prompt connection

| Variable                | Description                                                           | Default |
| ----------------------- | --------------------------------------------------------------------- | ------- |
| prompt_connection_color | color of prompt connection                                            | 6C6C6C  |
| prompt_connection_icon  | repeated symbol that spans gap between left and right sides of prompt | ' '     |

## Right Prompt Items

| Variable           | Description                                        | Default                                  |
| ------------------ | -------------------------------------------------- | ---------------------------------------- |
| right_prompt_items | order of right prompt items that will be displayed | 'status' 'cmd_duration' 'context' 'jobs' |

### status

| Variable             | Description                                                    | Default |
| -------------------- | -------------------------------------------------------------- | ------- |
| status_success_icon  | symbol to display when the last command in a pipeline succeeds | '✔'     |
| status_success_color | color of successful pipeline's status                          | 5FAF00  |
| status_failure_icon  | symbol to display when the last command in a pipeline fails    | '✘'     |
| status_failure_color | color of failed pipeline's status                              | D70000  |

### cmd_duration

| Variable               | Description                                                        | Default |
| ---------------------- | ------------------------------------------------------------------ | ------- |
| cmd_duration_color     | color of cmd_duration output                                       | 87875F  |
| cmd_duration_decimals  | number of decimals to display after seconds place                  | 0       |
| cmd_duration_threshold | number of milliseconds that duration must exceed to produce output | 3000    |
