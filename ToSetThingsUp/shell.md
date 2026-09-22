# Shell

Shells are commands executed in terminals. It is interpreted by a shell interpreter, like bash and zshell. Use can either type command in an interactive session in the terminal, or executing a shell script `.sh` which contains the commands.

Programs are in essence (binary) files and commands like `python`, `ls`, `cd` are pointers to some binary files. They were allocated by searching through the directories in environment variable `PATH`. This is why every time after downloading a software or a package control, we need to `export PATH=/usr/local/bin:/usr/bin:$PATH` to update environment variable `PATH`. (using `export` enables all the child processes spawned by current process to use the same environment variable)

There are some current rc files in [shellrcs](./shellrcs). 

## Shell script

`#!` is called Shebang, it has to be the first two charaters of a file
`#!/bin/bash`/`#!/bin/zsh` specifies which shell interpreter to use for executing the script. It can be very flexible, like `#!/usr/bin/env zsh` when you don't know where `zsh` binary file is (This command is just using `PATH` to find where `zsh` is)

## Interpreter settings

### bash

***On MacOS***

use `.bash_profile` or `.bashrc` for configuring

### zshell

***On MacOS***

use `.zprofile` or `.zshrc` for configuring

## Glossary

Environment variable: just like variable, but can be accessed while executing jobs
