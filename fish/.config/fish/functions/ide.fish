function ide --description 'Launch only the IDE layout (lighter than work) in the current dir'
    if set -q ZELLIJ
        zellij action new-tab --layout ide --name IDE
    else
        set -l sess (basename $PWD | string replace -ra '[^A-Za-z0-9_-]' _)
        zellij --session $sess --layout ide
    end
end
