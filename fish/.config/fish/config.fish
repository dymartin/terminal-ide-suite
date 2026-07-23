# fish top-level config. Tool init + abbreviations live in conf.d/ (auto-sourced).
if status is-login
    # Homebrew-on-Linux on PATH for login shells.
    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
    fish_add_path -g $HOME/.local/bin
end

set -gx EDITOR hx
set -gx VISUAL hx
# Truecolor so Helix/Yazi/Starship themes render inside Zellij + Windows Terminal.
set -gx COLORTERM truecolor

# Interactive-only bits.
if status is-interactive
    set -g fish_greeting ""
end
