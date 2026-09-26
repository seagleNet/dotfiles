set -gx COLORTERM truecolor

# bat pager
if type -q bat
    set -gx PAGER bat
    # set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
else if type -q batcat
    set -gx PAGER batcat
    # set -gx MANPAGER "sh -c 'col -bx | batcat -l man -p'"
else
    set -gx PAGER less
end
set -gx GIT_PAGER $PAGER

# editor
if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
end
set -q EDITOR; and set -gx GIT_EDITOR $EDITOR

# wsl
if type -q wslinfo && wslinfo --version >/dev/null 2>&1
    set -gx GALLIUM_DRIVER d3d12
    set -gx LIBVA_DRIVER_NAME d3d12
end
