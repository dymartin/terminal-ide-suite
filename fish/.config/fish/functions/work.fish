function work --description 'Attach-or-create the 4-screen Zellij IDE session for a project'
    # Resolve target dir: a path, or a zoxide query, or the current dir.
    set -l dir
    if test (count $argv) -eq 0
        set dir $PWD
    else if test -d $argv[1]
        set dir (realpath $argv[1])
    else
        set dir (zoxide query $argv[1] 2>/dev/null)
    end
    if test -z "$dir"; or not test -d "$dir"
        echo "work: no such project '$argv[1]'" >&2
        return 1
    end

    cd $dir
    # Session name = sanitised dir basename (zellij dislikes dots).
    set -l sess (basename $dir | string replace -ra '[^A-Za-z0-9_-]' _)

    # Prefer a project-local layout, else the global 'project' layout.
    set -l layout project
    if test -f $dir/.zellij/project.kdl
        set layout $dir/.zellij/project.kdl
    end

    # Don't nest sessions.
    if set -q ZELLIJ
        echo "work: already inside Zellij — use Alt+[1-4] to switch screens." >&2
        return 1
    end

    if zellij list-sessions -s 2>/dev/null | string match -qr "^$sess\$"
        zellij attach $sess
    else
        zellij --session $sess --layout $layout
    end
end
