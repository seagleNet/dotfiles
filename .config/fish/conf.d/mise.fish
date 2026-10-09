# A mise from mise.run (Debian) lives in ~/.local/bin and doesn't activate
# itself. Arch's mise package (/usr/bin/mise) does that through its own
# vendor_conf.d/mise-activate.fish, which runs after all of conf.d, so it's
# left alone here.
if test -x ~/.local/bin/mise
    ~/.local/bin/mise activate fish | source
end
