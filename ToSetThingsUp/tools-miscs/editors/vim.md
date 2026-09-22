# Vim

see the [vimrc](./.vimrc) file for the config

some other configs may be located in `~/.vim/` 
[vim-plug](https://github.com/junegunn/vim-plug): vim plugin manager



## Cheatsheet

### Mode Switching

Always know which mode you're in.

| Key          | Action                                         |
| :----------- | :--------------------------------------------- |
| `Esc`        | Back to **Normal mode**                        |
| `i`          | Enter **Insert mode** (before cursor)          |
| `I`          | Insert at beginning of line                    |
| `a`          | Insert after cursor                            |
| `A`          | Insert at end of line                          |
| `o`          | Open new line below and insert                 |
| `O`          | Open new line above and insert                 |
| `v`          | Enter **Visual mode** (character selection)    |
| `V`          | Enter **Visual line mode**                     |
| `Ctrl` + `v` | Enter **Visual block mode** (column selection) |
| `:`          | Enter **Command-line mode**                    |


### Cursor Movement (Normal Mode)

| Key          | Action                                    |
| :----------- | :---------------------------------------- |
| `h`          | Move left one character                   |
| `j`          | Move down one line                        |
| `k`          | Move up one line                          |
| `l`          | Move right one character                  |
| `w`          | Jump to start of next word                |
| `b`          | Jump to start of previous word            |
| `e`          | Jump to end of current word               |
| `0`          | Jump to beginning of line                 |
| `^`          | Jump to first non-blank character of line |
| `$`          | Jump to end of line                       |
| `gg`         | Go to first line of file                  |
| `G`          | Go to last line of file                   |
| `:n`         | Go to line number `n` (e.g. `:10`)        |
| `Ctrl` + `f` | Page down                                 |
| `Ctrl` + `b` | Page up                                   |


### Editing (Normal Mode)

#### Delete / Cut

| Key          | Action                               |
| :----------- | :----------------------------------- |
| `x`          | Delete character under cursor        |
| `X`          | Delete character before cursor       |
| `d` + motion | Delete (cut) to motion target        |
| `dd`         | Delete entire current line           |
| `dw`         | Delete from cursor to end of word    |
| `d$`         | Delete from cursor to end of line    |
| `d0`         | Delete from cursor to start of line  |
| `D`          | Delete to end of line (same as `d$`) |

#### Copy (Yank)

| Key          | Action                   |
| :----------- | :----------------------- |
| `y` + motion | Yank to motion target    |
| `yy`         | Yank entire current line |
| `yw`         | Yank one word            |
| `y$`         | Yank to end of line      |
| `y0`         | Yank to start of line    |

#### Paste

| Key  | Action              |
| :--- | :------------------ |
| `p`  | Paste after cursor  |
| `P`  | Paste before cursor |

#### Undo / Redo

| Key          | Action               |
| :----------- | :------------------- |
| `u`          | Undo last change     |
| `Ctrl` + `r` | Redo (undo the undo) |

#### Replace / Change

| Key        | Action                                          |
| :--------- | :---------------------------------------------- |
| `r` + char | Replace character under cursor                  |
| `R`        | Enter Replace mode (overwrite)                  |
| `cw`       | Delete word and enter Insert mode (change word) |
| `cc`       | Delete line and enter Insert mode               |
| `C`        | Delete to end of line and enter Insert mode     |
| `s`        | Delete character and enter Insert mode          |
| `S`        | Delete line and enter Insert mode               |


### Visual Mode Operations

| Key             | Action                         |
| :-------------- | :----------------------------- |
| `v`             | Start character-wise selection |
| `V`             | Start line-wise selection      |
| `Ctrl` + `v`    | Start block-wise selection     |
| Select then `d` | Delete selected text           |
| Select then `y` | Yank selected text             |
| Select then `>` | Indent right                   |
| Select then `<` | Indent left                    |


### Search and Replace

#### Search

| Key        | Action                                |
| :--------- | :------------------------------------ |
| `/pattern` | Search forward for `pattern`          |
| `?pattern` | Search backward for `pattern`         |
| `n`        | Next match                            |
| `N`        | Previous match                        |
| `*`        | Search forward for word under cursor  |
| `#`        | Search backward for word under cursor |

#### Replace (Command-line mode)

vim

```
:s/old/new/      " Replace first 'old' on current line
:s/old/new/g     " Replace all 'old' on current line
:%s/old/new/g    " Replace all 'old' in entire file
:%s/old/new/gc   " Replace all with confirmation
:3,10s/old/new/g " Replace between lines 3 and 10
```


### File Operations (Command-line Mode)

| Command       | Action                                |
| :------------ | :------------------------------------ |
| `:w`          | Save file                             |
| `:w filename` | Save as `filename`                    |
| `:q`          | Quit                                  |
| `:q!`         | Force quit (discard changes)          |
| `:wq` or `:x` | Save and quit                         |
| `ZZ`          | Save and quit (Normal mode)           |
| `:e filename` | Open another file                     |
| `:e!`         | Reload current file (discard changes) |
| `:ls`         | List open buffers                     |
| `:b n`        | Switch to buffer number `n`           |


### Useful Shortcuts

| Key    | Action                         |
| :----- | :----------------------------- |
| `>>`   | Indent current line right      |
| `<<`   | Indent current line left       |
| `==`   | Auto-indent current line       |
| `gg=G` | Auto-indent entire file        |
| `.`    | Repeat last change             |
| `J`    | Join next line to current line |
| `~`    | Toggle case of character       |

## neovim

refer to this [article](https://martinlwx.github.io/zh-cn/config-neovim-from-scratch/) for the neovim config

[Lazy.nvim](https://lazy.folke.io): plugin manager for neovim
