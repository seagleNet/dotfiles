# PATH additions for sh/bash, sourced by ~/.profile and ~/.bashrc
# (fish has the same list in config.fish). Missing directories are skipped and
# existing entries aren't added twice, so sourcing this more than once is fine.
# Each directory is prepended, so the last one listed ends up first in PATH.
for dir in \
    /opt/nvim-linux-arm64/bin \
    /opt/nvim-linux-x86_64/bin \
    /opt/google-cloud-cli/bin \
    "$HOME"/.local/share/gem/ruby/*/bin \
    "$HOME/go/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "$HOME/.krew/bin" \
    "$HOME/.npm/bin" \
    "$HOME/.opencode/bin" \
    "$HOME/bin"; do
    case ":$PATH:" in
        *":$dir:"*) ;;
        *) [ -d "$dir" ] && PATH="$dir:$PATH" ;;
    esac
done
unset dir
export PATH
