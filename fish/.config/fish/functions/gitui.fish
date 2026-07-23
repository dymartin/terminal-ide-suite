function gitui --description 'Open the Git screen (Lazygit + advanced shell)'
    if set -q ZELLIJ
        zellij action new-tab --layout git --name Git
    else
        set -l sess (basename $PWD | string replace -ra '[^A-Za-z0-9_-]' _)
        zellij --session $sess --layout git
    end
end
