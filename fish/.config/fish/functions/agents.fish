function agents --description 'Open the AI Lab (CAO supervisor/worker orchestration)'
    if not type -q cao
        echo "agents: CAO not installed — see github.com/awslabs/cli-agent-orchestrator" >&2
        return 1
    end
    if set -q ZELLIJ
        zellij action new-tab --layout ailab --name AILab
    else
        set -l sess (basename $PWD | string replace -ra '[^A-Za-z0-9_-]' _)
        zellij --session $sess --layout ailab
    end
end
