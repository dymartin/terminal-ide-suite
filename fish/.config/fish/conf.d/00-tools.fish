# Initialise external tools. conf.d/ is auto-sourced by fish.
status is-interactive; or exit

# mise (runtimes) must come early so shims are on PATH for everything else.
if type -q mise
    mise activate fish | source
end

type -q starship; and starship init fish | source
type -q zoxide;   and zoxide init fish | source
type -q direnv;   and direnv hook fish | source

# fzf key bindings + completions (Ctrl-T files, Ctrl-R history, Alt-C cd).
if type -q fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_DEFAULT_OPTS '--height 40% --layout reverse --border --preview "bat --style=numbers --color=always {} 2>/dev/null || eza -la {}"'
end
