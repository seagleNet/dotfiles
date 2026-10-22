# Neither mise.run's ~/.local/bin/mise nor Arch's package activates itself
# (the package only ships completions), so do it here for whichever is on PATH.
# Skip if something else (e.g. omarchy's shell setup) already did.
if status is-interactive; and not set -q MISE_SHELL
    if test -x ~/.local/bin/mise
        ~/.local/bin/mise activate fish | source
    else if type -q mise
        mise activate fish | source
    end
end
