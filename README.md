# terminal-ide-suite — Terminal-Native IDE (WSL2 + Zellij)

My custom multi-screen command line IDE. Code editor designed for terminal-first workflows. Made from open source components.

`work <project>` launches a 4-screen Zellij session with the right environment pre-loaded.

## Features
- **Per-project startup:** A single command opens a project in a saved workspace layout. Tools, tasks, and configuration files are loaded in place.
- **Four-pane workspace:** The CLI is divided into areas for editing code, reviewing changes, running and testing the app, and orchestrating AI assistants.
- **AI orchestration:** Multiple assistants in the same terminal for individual tasks, larger work can be delegated to multiple agents.
- **Updates:** One command updates the installed tools, and dependency version bumps can be surfaced as pull requests.

The environment is reproducable and can be reinstalled on another machine.

## Stack

| Layer            | Tool |
|------------------|------|
| Host terminal    | Windows Terminal |
| Linux            | WSL2 (Ubuntu) |
| Workspace shell  | Zellij |
| Text Editor           | Helix (`hx`) |
| Shell   | fish + Starship |
| File explorer    | Yazi |
| Git TUI           | Lazygit |
| Search / find    | ripgrep (`rg`), fd, fzf |
| Navigation       | zoxide |
| Runtimes / env   | mise, direnv |
| Task runner      | just |
| Reload-on-change | watchexec |
| AI (in-editor)   | Claude Code, OpenCode |
| AI (orchestration)| CAO — `awslabs/cli-agent-orchestrator` |
| Local models     | Ollama |

## Install

### 0. Windows host

In an **elevated PowerShell**:

```powershell
winget install Microsoft.WindowsTerminal   # if not already installed
wsl --install -d Ubuntu                     # reboot when prompted
```

After reboot, launch Ubuntu and create Linux user. For the file-tree and prompt
glyphs to render, install a [Nerd Font](https://www.nerdfonts.com) and set it as the font for the Ubuntu profile in Windows Terminal settings.

### 1. Inside WSL

```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/dymartin/terminal-ide-suite.git ~/terminal-ide-suite
cd ~/terminal-ide-suite
./bootstrap.sh                            # installs everything + stows configs
```

`bootstrap.sh` is idempotent — safe to re-run. It installs the toolchain (Homebrew +
apt + mise + Ollama + agents), then symlinks configs with GNU stow.

### 2. Daily use

```bash
work myproject     # attach-or-create the 4-screen Zellij session for a project
dev-init           # scaffold the current dir into a managed project
agents             # open the CAO AI Lab
```

Inside Terminal: `Alt+1` IDE · `Alt+2` Git · `Alt+3` Run/Debug · `Alt+4` AI Lab.

## Updating

- **`update`** runs [topgrade](https://github.com/topgrade-rs/topgrade), upgrading the
  whole stack in one pass — Homebrew, mise, apt, and any package managers it detects.
- Homebrew packages are declared in the **`Brewfile`**: `brew bundle` installs the set,
  `brew bundle cleanup` removes anything not listed.
- **Renovate** (`renovate.json`) opens pull requests to bump pinned versions
  (e.g. in `mise.toml`) automatically once the repo is hosted on GitHub.

## Layout

Stow packages (each mirrors `$HOME`):
`fish zellij helix yazi lazygit starship git bin cao topgrade`. Apply individually with
`stow <pkg>` from `~/terminal-ide-suite`.
