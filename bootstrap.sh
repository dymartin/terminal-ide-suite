#!/usr/bin/env bash
# Idempotent setup for the terminal-native IDE environment (WSL2/Ubuntu).
# Safe to re-run. Run from the repo root:  ./bootstrap.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

# --- Phase B: base packages ------------------------------------------------
log "apt base packages"
sudo apt-get update -y
sudo apt-get install -y \
  build-essential curl git file procps unzip tmux fish stow direnv

# --- Phase C: Homebrew-on-Linux + CLI tool suite ---------------------------
if ! have brew; then
  log "installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Make brew available in THIS shell for the rest of bootstrap.
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

log "brew CLI tool suite"
brew install \
  zellij helix yazi lazygit starship fzf ripgrep fd zoxide \
  just watchexec gh bat eza git-delta

# --- Phase D: runtimes -----------------------------------------------------
if ! have mise; then
  log "installing mise"
  curl -fsSL https://mise.run | sh
fi

# --- Phase E: AI layer -----------------------------------------------------
if ! have ollama; then
  log "installing Ollama"
  curl -fsSL https://ollama.com/install.sh | sh
fi
log "pulling local models (coder + small planner) — skip if offline"
ollama pull qwen2.5-coder:7b || echo "  (ollama pull skipped)"
ollama pull llama3.2:3b       || echo "  (ollama pull skipped)"

# Claude Code, OpenCode, CAO: install commands change over time — confirm docs.
if ! have claude;   then log "install Claude Code manually (see README / docs)"; fi
if ! have opencode; then log "install OpenCode manually (see README / docs)";   fi
if ! have cao;      then log "install CAO: github.com/awslabs/cli-agent-orchestrator"; fi

# --- Stow all config packages ---------------------------------------------
log "stowing configs"
cd "$ROOT"
for pkg in fish zellij helix yazi lazygit starship git bin cao; do
  stow -v --restow --target "$HOME" "$pkg"
done

# --- Default shell ---------------------------------------------------------
FISH_BIN="$(command -v fish)"
if ! grep -q "$FISH_BIN" /etc/shells; then echo "$FISH_BIN" | sudo tee -a /etc/shells; fi
if [ "${SHELL:-}" != "$FISH_BIN" ]; then
  log "setting fish as default shell (may prompt for password)"
  chsh -s "$FISH_BIN" || echo "  (chsh skipped — run manually)"
fi

log "Done. Open a new terminal, then:  work <project>"
