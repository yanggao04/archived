# Tmux

see the [tmux.conf](./.tmux.conf) file for the config

tmux: terminal multiplexer — one terminal, many panes and windows

## Cheatsheet

> Prefix key is `Ctrl`+\` (changed from the default `Ctrl+b`).
> In the tables below, `<prefix>` means "press `Ctrl`+\` first, then the key".

### Session

| Command                  | Action                            |
| :----------------------- | :-------------------------------- |
| `tmux`                   | Start a new session               |
| `tmux new -s name`       | Start a new named session         |
| `tmux ls`                | List all sessions                 |
| `tmux a`                 | Attach to last session            |
| `tmux a -t name`         | Attach to session `name`          |
|` tmux rename-session new_name` | Rename current session 		 |
|`tmux rename-session -t old_name new_name`| Rename session 	 |
| `tmux kill-session -t n` | Kill session `n`                  |
| `tmux kill-server`       | Kill all sessions                 |
| `<prefix>` + `d`         | Detach from current session       |
| `<prefix>` + `s`         | List and switch sessions          |
| `<prefix>` + `$`         | Rename current session            |
| `<prefix>` + `(` / `)`   | Switch to previous / next session |

### Window

| Key                  | Action                       |
| :------------------- | :--------------------------- |
| `<prefix>` + `c`     | Create a new window          |
| `<prefix>` + `,`     | Rename current window        |
| `<prefix>` + `&`     | Close current window         |
| `<prefix>` + `n`     | Next window                  |
| `<prefix>` + `p`     | Previous window              |
| `<prefix>` + `0`…`9` | Switch to window by number   |
| `<prefix>` + `w`     | List windows                 |
| `<prefix>` + `f`     | Find window by name          |
| `<prefix>` + `.`     | Move window to another index |

### Pane

| Key                    | Action                                    |
| :--------------------- | :---------------------------------------- |
| `<prefix>` + `|`       | Split vertically (side by side)           |
| `<prefix>` + `-`       | Split horizontally (top / bottom)         |
| `<prefix>` + `x`       | Close current pane                        |
| `<prefix>` + `z`       | Toggle pane zoom (fullscreen)             |
| `<prefix>` + `h/j/k/l` | Move to left / down / up / right pane     |
| `<prefix>` + `o`       | Cycle through panes                       |
| `<prefix>` + `;`       | Toggle to last active pane                |
| `<prefix>` + `q`       | Show pane numbers (press number to jump)  |
| `<prefix>` + `{` / `}` | Swap pane with previous / next            |
| `<prefix>` + `!`       | Break pane into its own window            |
| `<prefix>` + `space`   | Cycle through pane layouts                |
| `<prefix>` + `H/J/K/L` | Resize pane left / down / up / right      |
| `<prefix>` + `M-←↓↑→`  | Resize pane with arrow keys (Alt + arrow) |

### Copy Mode

| Key                | Action                  |
| :----------------- | :---------------------- |
| `<prefix>` + `[`   | Enter copy mode         |
| `h / j / k / l`    | Move cursor (vi-style)  |
| `w / b`            | Jump by word            |
| `0 / $`            | Start / end of line     |
| `g / G`            | Top / bottom of buffer  |
| `Ctrl` + `u` / `d` | Page up / down          |
| `/pattern`         | Search forward          |
| `?pattern`         | Search backward         |
| `n / N`            | Next / previous match   |
| `v`                | Start selection         |
| `y` or `Enter`     | Copy selection and exit |
| `q` or `Esc`       | Exit copy mode          |
| `<prefix>` + `]`   | Paste copied text       |

### Misc

| Key              | Action                     |
| :--------------- | :------------------------- |
| `<prefix>` + `:` | Enter command prompt       |
| `<prefix>` + `?` | List all key bindings      |
| `<prefix>` + `r` | Reload `~/.tmux.conf`      |
| `<prefix>` + `t` | Show clock in current pane |
| `<prefix>` + `S` | Toggle synchronize-panes   |

### Mouse

Mouse is enabled (`set -g mouse on`), so you can:

| Action                       | Effect                                |
| :--------------------------- | :------------------------------------ |
| Click a pane                 | Focus that pane                       |
| Drag a pane border           | Resize the pane                       |
| Click a window in status bar | Switch to that window                 |
| Scroll wheel                 | Enter copy mode and scroll history    |
| Select text + release        | Copy to system clipboard (if enabled) |

## Command-line mode (after `<prefix>` + `:`)

| Command                     | Action                            |
| :-------------------------- | :-------------------------------- |
| `:new-window`               | Create a new window               |
| `:split-window -h`          | Split pane horizontally           |
| `:split-window -v`          | Split pane vertically             |
| `:resize-pane -L 10`        | Resize pane left by 10 cells      |
| `:swap-pane -U / -D`        | Swap pane up / down               |
| `:setw synchronize-panes`   | Toggle input sync across panes    |
| `:source-file ~/.tmux.conf` | Reload config                     |
| `:list-keys`                | List all key bindings             |
| `:kill-server`              | Kill tmux server and all sessions |

## Scripting / CLI

bash

```
# Start a detached session named "work"
tmux new -d -s work

# Send a command to a specific pane
tmux send-keys -t work:0.1 "htop" Enter

# Split a pane from outside tmux
tmux split-window -h -t work

# Capture pane output to a file
tmux capture-pane -t work:0.0 -p > out.txt

# Run a script in a new session
tmux new -s run 'bash script.sh'
```



## Related

- [tmux wiki](https://github.com/tmux/tmux/wiki)
- [tmux man page](https://man7.org/linux/man-pages/man1/tmux.1.html)
- [Oh my tmux!](https://github.com/gpakosz/.tmux) — a popular tmux config
