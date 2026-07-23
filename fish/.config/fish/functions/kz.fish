function kz --description 'Kill a Zellij session by name (default: current dir session)'
    set -l sess $argv[1]
    test -z "$sess"; and set sess (basename $PWD | string replace -ra '[^A-Za-z0-9_-]' _)
    zellij delete-session --force $sess; and echo "killed session: $sess"
end
