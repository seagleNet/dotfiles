if status is-interactive
    set fish_greeting
    set -g fish_key_bindings fish_vi_key_bindings
    # --print-full-init avoids a second starship spawn via psub
    type -q starship; and starship init fish --print-full-init | source
end

# The next line updates PATH for the Google Cloud SDK.
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

# -g keeps these session-scoped instead of persisting in fish_user_paths;
# missing directories are skipped, so this is safe to share across machines
fish_add_path -g \
    $HOME/.opencode/bin \
    $HOME/.npm/bin \
    $HOME/.krew/bin \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/go/bin \
    $HOME/.local/share/gem/ruby/3.4.0/bin \
    /opt/google-cloud-cli/bin \
    /opt/nvim-linux-x86_64/bin
