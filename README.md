# terminal-ide-suite — Terminal-Native IDE (WSL2 + Zellij)

A terminal-native development environment that approximates a GUI IDE, driven from the
keyboard with **Zellij** as the workspace shell. `work <project>` launches a 4-screen
Zellij session (IDE / Git / Run-Debug / AI Lab) with the right environment pre-loaded.

See the full design in the implementation plan. This repo is the concrete artifact.

## Stack

| Layer            | Tool |
|------------------|------|
| Host terminal    | Windows Terminal |
| Linux            | WSL2 (Ubuntu) |
| Workspace shell  | Zellij |
| Editor           | Helix (`hx`) |
| Shell / prompt   | fish + Starship |
| File explorer    | Yazi |
| Git UI           | Lazygit |
| Search / find    | ripgrep (`rg`), fd, fzf |
| Navigation       | zoxide |
| Runtimes / env   | mise, direnv |
| Task runner      | just |
| Reload-on-change | watchexec |
| AI (in-editor)   | Claude Code, OpenCode |
| AI (orchestration)| CAO — `awslabs/cli-agent-orchestrator` |
| Local models     | Ollama |

## Install

### 0. Windows host (do this once, manually — needs admin + reboot)

In an **elevated PowerShell**:

```powershell
winget install Microsoft.WindowsTerminal          # if not already installed
winget install --id DEVCOM.JetBrainsMonoNerdFont  # icons for Yazi/Starship/Helix
wsl --install -d Ubuntu                            # reboot when prompted
```

After reboot, launch Ubuntu, create your Linux user, then set the Windows Terminal
Ubuntu profile font to "JetBrainsMono Nerd Font".

### 1. Inside WSL

```bash
sudo apt update && sudo apt install -y git
git clone <your-fork-url> ~/terminal-ide-suite   # or copy this folder there
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

Inside Zellij: `Alt+1` IDE · `Alt+2` Git · `Alt+3` Run/Debug · `Alt+4` AI Lab.

## Layout

Stow packages (each mirrors `$HOME`):
`fish zellij helix yazi lazygit starship git bin cao`. Apply individually with
`stow <pkg>` from `~/terminal-ide-suite`.
