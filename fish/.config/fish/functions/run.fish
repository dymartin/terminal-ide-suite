function run --description 'Open the Run/Debug screen; runs `just dev` if available'
    if set -q ZELLIJ
        zellij action new-tab --layout run --name Run
    else
        set -l sess (basename $PWD | string replace -ra '[^A-Za-z0-9_-]' _)
        zellij --session $sess --layout run
    end
end
