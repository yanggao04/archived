## CC switch

an app that provides uniform agent-provider-model interface

https://github.com/farion1231/cc-switch

## CodeX

### installation

Two main ways to install the Codex CLI (`codex`), both give the same tool:

- **npm** (if you already have Node):
  ```sh
  npm install -g @openai/codex
  ```
- **Standalone installer** (official "website" method — downloads a prebuilt binary):
  ```sh
  curl -fsSL https://chatgpt.com/codex/install.sh | sh        # macOS / Linux
  # Windows (PowerShell):
  #   powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
  ```

Also possible: `brew install --cask codex`, or grab a binary for your platform from the GitHub
releases.

Different ways to launch Codex:

- **Terminal (CLI):** just run `codex`, then pick **Sign in with ChatGPT** (uses your Plus/Pro/…
  plan) or sign in with an API key. Slash commands (`/init`, `/compact`, `/plan`, …) live here.
- **Desktop app:** `codex app` (or the Codex App page) — a graphical UI over the same CLI.
- **In an IDE:** install the Codex extension for VS Code / Cursor / Windsurf.

### config

`config.toml` for configurations. Can either login with credential or use an API key, or to change to an external model (support OpenAI API):

```toml
model = "deepseek-v4-flash" # the exact model name provided through API
model_provider = "deepseek" # need to match [model_providers.<providername>]

[model_providers.deepseek]
name = "DeepSeek"
base_url = "https://api.deepseek.com"
env_key = "DEEPSEEK_ENV_KEY"
wire_api = "responses"
```

### command

| command     | usage |
| ----------- | ----- |
| codex login | login |
| codex logout | log out |
| codex app|activate desktop app|
|/init|initialise|
|/model|switch model|
|/compact|compress context |
|/new|start a new session|
|/plan|enable plan mode|
|/ask|just ask, do not execute|
|/settings | open settings|

## Deepseek Harness

Updated 2026. A minimalistic, heavily plugin-able harness (Cordis-based).

### Installation & boot

```sh
npm install -g @deepseek-ai/dsh   # provides the `dsh` binary
```

Everything else lives under `$DSH_HOME` (default `~/.dsh`): `profiles/`, `sessions/`,
`storages/`, plus `settings.yaml`, `.credentials.yaml`.

Built on **Cordis**: a *profile* is an ordered stack of plugin-bundle patch layers under your
own `cordis.patch.yml`. Composition order: each bundle in `dsh.profile.bundles` → the profile's
`cordis.patch.yml` → home `$DSH_HOME/cordis.patch.yml` → any `--patch` overlays.

Boot the Web GUI (default `http://127.0.0.1:3080`):

```sh
dsh web                       # alias of `dsh --profile web`
dsh --profile web --port 8080 # other port
dsh --profile web --no-open   # don't open a browser
```

Web flags: `--host`, `--port` (`0` = auto), `--no-open`, `--trusted-host` (`0.0.0.0` host is
rejected for safety). The `web`/`headless` profiles auto-init on first use; other profiles are
made via `dsh plugin`. Your launch directory is the workspace root.

Headless one-shot: `dsh --profile headless "task"` — one fresh session, print answer, exit.
Inspect the composed tree without booting: `dsh --dump-config` / `--dump-default-config`.

**Stopping / backgrounding.** `dsh web` is a foreground process, not a daemon — it runs in the
terminal that started it and "lives" only while that terminal stays open:

- **Stop it normally:** press `Ctrl-C` in that terminal. The harness drains and exits cleanly on
  `SIGINT`/`SIGTERM`, releasing the port (`3080`).
- **Run it in the background on purpose** (so you can keep using the terminal and it keeps
  serving) with `nohup ... &` — `&` backgrounds it, `nohup` keeps it alive when the terminal
  closes, and redirecting logs to a file keeps the output readable:

  ```sh
  nohup dsh web --no-open > ~/.dsh-web.log 2>&1 &
  ```

  (`disown` does the same as `nohup` for a job already started with `&`.)
- **Find and stop a backgrounded instance** with `lsof` then `kill`:

  ```sh
  lsof -nP -iTCP:3080 -sTCP:LISTEN   # shows the PID listening on 3080 (or use: pgrep -fl dsh)
  kill <pid>                         # clean exit; it exits on SIGTERM
  ```

  To pipe it (use `lsof -t` to print only the PID, or `pkill`/`xargs`):
  
```sh
  lsof -t -nP -iTCP:3080 -sTCP:LISTEN | xargs kill      # kill whatever listens on 3080
  kill $(lsof -t -nP -iTCP:3080 -sTCP:LISTEN)           # same, using command substitution
  pkill -f "dsh"                                        # or kill by process name instead
```

If `kill` (SIGTERM) doesn't stop it, add `-9` to force it.
- **To avoid it auto-running in the background:** don't background it when you don't need it, and
  don't add it to Login Items or a LaunchAgent (if it previously auto-started, remove that entry /
  launchd plist and kill the running instance). Use `dsh web --no-open` if you don't want a
  browser tab popping up — the process still stops with `Ctrl-C`.

### Config

Manual config is plain YAML plus a few env seams:

| file / seam | controls | effect |
| --- | --- | --- |
| `$DSH_HOME/settings.yaml` | default model/provider, `reasoningEffort`, `llm-*` sections (Web **Models** page writes this) | hot-reload, no restart |
| `$DSH_HOME/.credentials.yaml` | API keys (e.g. `DEEPSEEK_API_KEY`) | per request |
| `.../profiles/web/cordis.patch.yml` | Web profile's plugin patch layer | next boot |
| `$DSH_HOME/cordis.patch.yml` | home-level patch, every profile | next boot |
| `DSH_PERMISSION_MODE` | sandbox mode (`workspace-write` default) | at launch |

Rules:
- A patch **replaces** a row's whole `config` (no merge); last write wins.
- Add/change plugins in `cordis.patch.yml` (`insert` / `disabled` / id-targeted `config`), then
  **restart `dsh web`**. `settings.yaml` needs no restart:

  ```yaml
  agent-default-model:
    provider: deepseek-official
    model: deepseek-v4-flash
    reasoningEffort: low
  ```

To install plugins, use `dsh plugin --profile web add <source of plugin>` where the source can be `npm` pack name: `@nanmicoder/dsh-agent-teams`, GitHub repo: `"github:owner/repo"`, or local path.

Or, one can install plugin center as a plugin to browse plugins in the community. `dsh plugin --profile web add dsh-plugin`

### Agent presets

A preset is an agent-plane composition deciding one session's tools/persona/prompt. Shipped
presets are read-only (next to the deployment config): `standard` (full coding), `code`
(standard via the Code Mode SDK), `minimal` (persistent shell + editor), `cordis` (standard +
self-modification). Author your own under `$DSH_HOME/.agent-presets/<id>/`:

```text
$DSH_HOME/.agent-presets/economy/
├── agent.cordis.yml   # the composition (dir name = preset id)
└── preset.yml         # optional name + description
```

id = `[a-z0-9][a-z0-9-]*`. Presets are re-discovered live — no restart to use one.

To set one up:
1. Copy a shipped preset into `$DSH_HOME/.agent-presets/<id>/` (don't edit shipped files).
2. Edit `agent.cordis.yml`; rows publishing a service need a `cordis:group` with an
   `isolate: { <svc>: true }` realm.
3. Add `preset.yml` (name/description).
4. Start a **new** Web session and pick it; the default stays `standard`.

Example — token-light **`economy`**: a copy of `standard` with a more aggressive result pruner
(`thresholdChars: 8192→4096`, `head: 4096→2560`, `tail: 1024→512`) and a concise persona
(prefer `grep`/`offset:limit` reads over whole-file dumps). Pick 经济模式 (economy) in a new
session.

### Command

The launcher parses its own flags; the first token it doesn't recognize goes to the booted app
(`dsh --help` for launcher; `dsh --profile <name> --help` for the app).

| command | usage |
| --- | --- |
| `dsh web` | boot web profile (alias of `--profile web`) |
| `dsh --profile <name>` | boot profile under `$DSH_HOME/profiles/<name>` |
| `dsh --profile headless "job"` | one fresh session, print answer, exit |
| `dsh plugin --profile <name> <pnpm args>` | manage a profile's plugins via pnpm |
| `dsh -V` / `--version` | version |
| `dsh --patch <path>` | extra patch overlay (repeatable) |
| `dsh --dump-config` / `--dump-default-config` | print composed tree (with / without user layer) |

At runtime most "commands" aren't `dsh` subcommands but plugins in the profile (file tools,
bash, web search, skills, goals, subagents, workflows, jobs/schedule, dynamic Cordis plugin
authoring, plan mode) — enabled/disabled by editing `cordis.patch.yml`.

## Pi Agent

[document](https://pi.dev/docs/latest)

### Install

See website, or just install using `brew install pi-coding-agent`

### Configs

Pi loads `AGENTS.md` or `CLAUDE.md` at startup from:

- `~/.pi/agent/AGENTS.md` for global instructions
- parent directories, walking up from the current working directory
- the current directory

If a directory contains `AGENTS.override.md`, Pi loads it instead of `AGENTS.md`or `CLAUDE.md` from that directory. Context files from other directories still layer normally. One may use `--no-context-files` or `-nc` to disable loading.

Replace the default system prompt with:

- `.pi/SYSTEM.md` for a project
- `~/.pi/agent/SYSTEM.md` globally

Append to the default prompt without replacing it with `APPEND_SYSTEM.md`in either location.

### Command

#### Package command

```shell
pi install <source> [-l]     # Install package, -l for project-local
pi remove <source> [-l]      # Remove package
pi uninstall <source> [-l]   # Alias for remove
pi update [source|self|pi]   # Update pi only, or one package source
pi update --all              # Update pi and packages; reconcile pinned git refs
pi update --extensions       # Update packages only; reconcile pinned git refs
pi update --models           # Refresh model catalogs only
pi update --self             # Update pi only
pi update --extension <src>  # Update one package
pi list                      # List installed packages
pi config                    # Enable/disable package resources
```

Press `esc` to interrupt any current job.

#### Slash command

| `/login`/`logout` | Manage OAuth or API-key credentials |
| --- | --- |
| `/model` | switch models, `Ctrl+S` in the picker saves the startup default |
| `/thinking` | switch thinking level, `Ctrl+S` in the picker saves the startup default |
| `/scoped-models` | enable/disable models for `Ctrl+P` cycling |
| `/settings` | setting theme, message delivery, transport, and other preferences |
| `/resume` | pick from previous sessions, use `Ctrl+D` to delete ｜
| `/new` |  start a new session |
| `/name <name>` | set session displayed name |
| `/session` | show current session info |
| `/copy` | copy last assistant message to clipboard |
| `/compact [prompt]` | manually compact context, optionally with custom instructions |
| `/export [file]` | export session to HTML or JSON |
| `/import <file>` | import and resume a session from a JSON file |
|`/quit`| quit pi |
| `/tree` | jump to any point in a session and continue from there |
| `/fork` | create a new session from a previous user message |
| `/clone` | duplicate the current active branch into a new session |


skills are available as `/skill:<name>`

Pi also can explore different possibilities of conversations, so it can use the last couple of commands to make a session like Git's tree-like branches.

There are also many operations.
`@` for fuzzy find. 
`!<command>` to execute bash command and return the output to the model. 
`!!<command>` to execute bash command while not activating model at all.

### Userful Plugins

**ask-mode** `npm:@dreki-gg/pi-ask-mode`: using `/ask` to turn on/off read-only mode for agent or `/ask <prompt>`

**caveman** `git:github.com/jonjonrankin/pi-caveman`: succinct output to cut token expenses. use `/caveman config` to set default and `/caveman` to turn on/off

**output-style** `npm:pi-output-styles`: change the style of responses, uses `/style <style>` to change styles. Use `/style <style> --save` to save as user default. Can also edit `~/.pi/agent/pi-output-styles.json` to config.

**extension manager** `npm:@agentoom/pi-extension-manager`: use `/extension` to view and manage extensions

**rtk** `npm:pi-rtk`: auto filter to compress tool outputs in order to reduce token usage. Use `/rtk-on`/`/rtk-off` to turn on/off. There are also other settings.

**tscg** `npm:pi-tscg`: compress tool definitions and tool outputs. Use `/tscg` to set
