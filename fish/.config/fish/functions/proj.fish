function proj --description 'Fuzzy-pick a registered project and `work` it'
    set -l list $HOME/.config/dev/projects
    if not test -f $list
        echo "proj: no projects registered yet — run dev-init in a project first." >&2
        return 1
    end
    set -l dir (sort -u $list | fzf --prompt='project » ' --height 40% --reverse \
        --preview 'eza -la --git --icons {} 2>/dev/null || ls -la {}')
    test -n "$dir"; and work $dir
end
