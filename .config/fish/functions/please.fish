# polite bash commands: run args with sudo, or rerun the last command with sudo
function please
    if set -q argv[1]
        sudo -E $argv
    else
        printf '❯ sudo %s\n' $history[1]
        sudo -E fish -c $history[1]
    end
end
