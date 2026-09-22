# Apps and Configs on my Mac

## Issue Resolution for new installings

1.  `Apple could not verify “xxx” is free of malware that may harm your Mac or compromise your privacy.`

`System Settings` > `Privacy & Security` > `Security` > `"xxx" Open Anyway`

## Editors

please refer to the folder [editors](./editors)

## LaTeX

see [latex](./env/latex.md)

## HomeBrew

[brew](https://brew.sh)

installation: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

**formula**

Homebrew package definition that builds from upstream sources

**cask**

Homebrew package definition that installs pre-compiled binaries built and signed by upstream

possible target paths: `/opt/homebrew` or`/home/linuxbrew/.linuxbrew`

`brew update`: update current brew version. By setting `export HOMEBREW_NO_AUTO_UPDATE=1` in shell script to disable auto-updating

### Packages:

[core formulae in GitHub](https://github.com/Homebrew/homebrew-core/tree/ca889ec7d9ff7b67ca7cd0142b296e0134dd67a8)

`brew install <...>` or `brew install --cask <...>`

`brew upgrade <...>` for updating

#### Ice

[Ice in GitHub](https://github.com/jordanbaird/Ice): menu bar manager

`brew install --cask jordanbaird-ice`

shown as `jordanbaird-ice` in `cask`

macOS 26 Tahoe need to install [beta version from github](https://github.com/jordanbaird/Ice/releases)

#### rsync

[rsync in HomeBrew](https://formulae.brew.sh/formula/rsync): tool for synchronizing and copying

`brew install rsync`

#### neovim

`brew install neovim`

`nvim` to boot

#### zathura

lightweight real-time pdf viewer

[github link](https://github.com/pwmt/zathura)

#### fzf

fuzzy find
[github link](https://github.com/junegunn/fzf)

## Some useful apps/packages

#### Raycast

powerful tool: search, shortcuts, window arrangement, etc.

#### One Switch

`brew install --cask one-switch`
easy control, keep awake

#### Ice

menu bar manager, see **Ice** in **HomeBrew** section

#### Bartender 5

paid menu bar manager, similar to **Ice**

#### Scroll Reverser

making mouse and trackpad scrolling compatible

#### Dropover

desktop shelf to temporarily put files (for easy moves)

#### LaunchPalette (Optional)

quick navigate through 

#### Maccy

clipboard manager, keep track of history of clipboard

#### Rectangle (Optional)

windows manager, with shortcuts and snap areas

#### Every-PDF 

lightweight pdf/image editor: watermarks, editting, etc.

#### OpenMTP

cable transmitting files to android systems (Need to quite previews for connections)

#### Shottr

screenshot tool: [Website](https://shottr.cc), [Raycast extension](https://www.raycast.com/fernando_barrios/shottr)

#### Atoll

macos dynamic island tool: [github](https://github.com/Ebullioscopic/Atoll)

#### DockDoor (Optional)

macos dock window preview

#### LaunchOS (Optional)

get back macos startup page

#### AppFlowy

Offline notebook like notion

#### Typora

Markdown editor

#### Obsidian

Markdown editor + management + extensions

#### Joplin

Notebook, using Markdown format

#### Clash (Plus)

smart web proxy [cn website](https://clashcnweb.com/en/); [website](https://clashplus.io)

#### Shadowsocks/Shadowrocket

web proxy: [shadowrockets](https://shadowlaunch.com) (often app store); [shadowsocks](https://shadowsocks.org); [shadowsocks github](https://github.com/shadowsocks)

