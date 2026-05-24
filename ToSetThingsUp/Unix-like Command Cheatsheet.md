# Unix-like Command Cheatsheet

## All

### Running in background:

`nohup <command>`: 

prevent the process from being sent a 'stop' signal on logout. However, will generate `nohup.out` file for logging

`<command> &`:

to close the programme: `killall <program name>`

### checking the programmes running:

`lsof -i`: `lsos -i :<port number>` specifies a port to inspect

`ps -ef`

### ssh

>  see `ssh/keys.md` document

## Linux Only

### All Linux

### Debian

### Ubuntu

### Arch

### Linux

## MacOS Only

### Envs

fonts at `~/Library/Fonts`

to get access to e-book/android devices or MTP usb transfer, need tools like `openMTP`/`calibre`

### pbcopy / pbpaste

`pbcopy` puts something onto the clipboard. So if we want to copy something in the clipboard, can do `pbcopy < filename` or `command | pbcopy`.

`pbpaste` reads from the clipboard and writes to stdout. So one can paste from a clipboard by `pbpaste > filename`

## Some Tools/Packages

### fd

### fzf

Can download from github or package manager, which will typically be `~/.fzf`. `~/.fzf.bash` and `~/.fzf.zsh` are the config files.

Use `control+T` or type `fzf` to invoke fuzzy find in current directory.

When typing some commands in terminal and wanting to add a filename, can use `control+T` or type `**` followed by `tab` to invoke fuzzy find in currenct directory and complete the command with the filename.

Use `control+R` to invoke fuzzy find for history commands.

Use `fzf --preview '[command with {} for filename]'` to activate fuzzy find on the left and preview the command of using the filename selected in place of `{}` on the right.

Rules:

| Input    | Rules                                                        |
| -------- | ------------------------------------------------------------ |
| [text]   | fuzzy find [text]                                            |
| '[text]  | find exact [text] (anywhere in the file name with the match) |
| ^[text]  | matching prefix with [text]                                  |
| [text]$  | matching suffix with [text]                                  |
| ![text]  | exclude anything containing [text]                           |
| !^[text] | exclude any prefix with [text]                               |
| ![text]$ | exclude any suffix with [text]                               |

everything rule can be used together, seperated by space.

Can use `|` to indicate disjunction (needs space before and after `|`)

### git

config: see `~/.gitconfig`

4 areas

-  workspace: the files in the current home folder containing `.git` file as displayed. (any change here is "unstaged")
-  index/staging area: the changes that are ready to commit
-  local repository: the course of development of the repository, logging each commit and branch.
-  remote repository: the upstream repository on the server.

`git config`: check config e.g. `user.name`/`user.email`/`http.version`/`http.sslVerify`; `--global user.name/user.email` to change the name or email shown, and same for other configurations; `--list` to list

`git init`: initiate a git repository in the current directory

`git init <directory name>`: initiate a git repository in the given directory

`git clone <url> (<dir>)`: clone a the repository from a remote repository (to the specified directory)

`git add <files>`: add the files from workspace to the index (must have changes compared to the last commit)

`git commit`: commit the changes in the index to the repository, as a commit. Will pop up the default editor to edit the commit meesage. Can use `-m "commit messages"` to specify the commit message when committing. `-a` can be used to commit all changed files in the workspace (no need for `git add`)

​	 Can use `git config --global user.name "name"` and `git config --global user.email git@email.com` to update the name and email in the commit messages.

`git rm <file>`: remove the file from index and workspace. If changed and staged in index, need `-f` to force. Can specify `--cached` to only remove from index, not workspace. `-r` for a directory

`gits status`: show current branch, current branch vs remote branch, unstaged changes, untracked files (new files not git added). `-s` for a short output.

`git log`: show history commits. `--oneline`: make a brief one line description; `--graph`: graphically show the history (branch, merge, ...); `--author="name"`/`--since="time"`/`--until="time"`/`--grep="pattern"`: filter the outputs; `--stat`

`git blame [flags] <file>`: show info for every line in the file. `-L <start-line>,<end-line>`: specify the range of lines; `-M`: trace the lines being moved; `-C`: trace the lines renamed or copied; `--show-stats`

`git diff`: compare the index and the workspace

​	`git diff [commit hash]`: compare the current workspace and a commit

​	`git diff [commit hash] [commit hash]`: compare two commits.

`git reset [--soft | --mixed | --hard] [HEAD] [file]`: roll back to a specified version (a commit)

​	`file`: reset a specific file

​	`HEAD`: the commit current branch points to, normally the latest commit. It is the default option. Can use any commit hash or `HEAD^`/`HEAD^^`... meaning the second/third latest commit

​	`--mixed`: reset index, but not workspace

​	`--soft`: current branch points to the older commit, but index and workspace remain.

​	`--hard`: reset everything and delete later commits. In the risk of losing uncomitted changes and later commits.

`git revert <commit>`: retract a commit, not changing any other commits.

`git checkout`:

​	`<branch-name>`: switch to another branch

​	`-b <new-branch-name> [commit hash]`: create a new branch from the current `HEAD` (`commit hash` can be used to specifty which commit is the new branch created from)

​	`-`: switch to the last branch worked on

​	`-- <file>`: reset the file to the last commit, abort all uncommitted changes

​	`<commit-hash>`: restore the workspace to a specific commit. (This will create a detached HEAD. Any changes here won't affect the branch, but creating something not pointed to. Can create a new branch to point to the commit)

`git switch`: (Git 2.23 and later)

​	`<branch-name>`: switch to another branch

​	`-c <branch-name>`: create a new branch and switch to it

​	`-`: switch to the last branch worked on

​	`<commit-hash>`: restore the workspace to a specific commit. (This will create a detached HEAD. Any changes here won't affect the branch, but creating something not pointed to. Can create a new branch to point to the commit)

`git remote`: list all the remote repositories linked

​	`-v` (verbose): and show their URL

​	`add <remote-name> <remote-url>`: add a new remote repository with the specified url and give its the name.

​	`rename <old-name> <new-name>`: rename a remote repo

​	`remove <name>`: remove a remote repo from the repo

​	`set-url <name> <url>`: change a current name's url to another

​	`show <name>`: show info for a remote repo

`git fetch <name>`: fetch from a repo, feault name `origin`

​	if there are discrepancies, need `git merge <remote-name>/<branch>` to merge and resolve.

`git pull <name> <remote-branch>:<local-branch>`: short for `git fetch` + `git merge`. `:<local-branch>` can be omitted if the local branch is the current branch.

`git push`:

​	`<name> <local-branch>:<remote-branch>`: push the commits from local branch to the remote one. `--force` to force pushing and override if there's discrepany between local and remote (careful with this, better pull first then push). Can omit `:<remote-branch>` if the branch names are the same or if there's a default remote branch.

​	`<name> --delete <branch>`: delete a branch from the remote repo.

​	`-u <name> <local-branch>`/`--set-uupstream <name> <local-branch>`: creates an upstream counterpart branch for any future push/pull attempts from the local branch

`git branch` 

​	`-a`: list all the branches

​	`--set-upstream <remote-branch>`/`--set-upstream-to <remote-branch>`: set the branch as the default upstream branch for the current branch (for future `git pull`)

### curl

`-k`: bypassing SSL certificate verification
