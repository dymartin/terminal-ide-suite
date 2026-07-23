function zl --description 'Fuzzy-pick a Zellij session to attach (or kill with Ctrl-X)'
    set -l sess (zellij list-sessions -sn 2>/dev/null \
        | fzf --prompt='zellij » ' --height 40% --reverse \
              --header 'enter: attach   ctrl-x: kill' \
              --bind 'ctrl-x:execute-silent(zellij delete-session {})+reload(zellij list-sessions -sn)')
    test -n "$sess"; and zellij attach $sess
end
