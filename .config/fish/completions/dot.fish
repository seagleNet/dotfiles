# dot wraps git against the bare dotfiles repo: reuse git's completions,
# pointed at that repo, and add dot's own subcommands.

function __dot_git_complete
    set -lx GIT_DIR ~/.dotfiles
    set -lx GIT_WORK_TREE ~
    complete -C (commandline -cp | string replace -r '^\s*\S+' git)
end

function __dot_secret_names
    string match -rg '^\s*"([^|"]+)\|' <~/.local/bin/dot
end

set -l dot_cmds bootstrap setup secrets

complete -c dot -f
complete -c dot -n "not __fish_seen_subcommand_from $dot_cmds" -a '(__dot_git_complete)'
complete -c dot -n __fish_use_subcommand -a bootstrap -d 'Clone dotfiles onto a fresh machine'
complete -c dot -n __fish_use_subcommand -a setup -d 'Install fisher and omarchy plugins'
complete -c dot -n __fish_use_subcommand -a secrets -d 'Sync private files with Bitwarden'

complete -c dot -n '__fish_seen_subcommand_from secrets; and not __fish_seen_subcommand_from pull push status' \
    -a 'pull push status'
complete -c dot -n '__fish_seen_subcommand_from secrets; and __fish_seen_subcommand_from pull push status' \
    -a '(__dot_secret_names)'
