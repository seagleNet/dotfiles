function update_completions
    set -l commands rustup kubectl helm k3d
    set -l check_mark "\033[1;32m\u2713\033[0m"
    set -l cross_mark "\033[1;31m\u2715\033[0m"

    for cmd in $commands
        if type -q $cmd
            printf '%b %s is installed - updating completions\n' $check_mark $cmd
            switch $cmd
                case rustup
                    $cmd completions fish > ~/.config/fish/completions/$cmd.fish
                case '*'
                    $cmd completion fish > ~/.config/fish/completions/$cmd.fish
            end
        else
            printf '%b %s is not installed - skipping\n' $cross_mark $cmd
        end
    end
end
