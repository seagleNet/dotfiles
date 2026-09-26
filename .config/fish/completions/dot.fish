# dot wraps git against the bare dotfiles repo
complete -c dot -w git
complete -c dot -n __fish_use_subcommand -f -a bootstrap -d 'Clone dotfiles onto a fresh machine'
complete -c dot -n __fish_use_subcommand -f -a setup -d 'Install fisher and omarchy plugins'
complete -c dot -n __fish_use_subcommand -f -a secrets -d 'Sync private files with Bitwarden'
complete -c dot -n '__fish_seen_subcommand_from secrets' -f -a 'pull push status'
