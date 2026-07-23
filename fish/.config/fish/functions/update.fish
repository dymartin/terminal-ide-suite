function update --description 'Update the whole stack via topgrade (brew, mise, apt, ...)'
    if not type -q topgrade
        echo "update: topgrade not installed (brew install topgrade)" >&2
        return 1
    end
    topgrade $argv
end
