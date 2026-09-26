# dotfiles

Personal config for Arch (incl. WSL), Omarchy and Debian machines: fish, bash,
vim/neovim, starship, git, ssh, ghostty and Omarchy/Hyprland overrides.

Files live at their normal location in `$HOME` — this is a bare git repo in
`~/.dotfiles` with `$HOME` as work tree, driven by the [`dot`](../.local/bin/dot)
wrapper. Edit configs in place, then `dot add` / `dot commit` / `dot push`.
Untracked files are hidden, so `dot status` only shows tracked changes.

## New machine

```bash
curl -fsSL https://raw.githubusercontent.com/seagleNet/dotfiles/master/.local/bin/dot | bash -s -- bootstrap
```

This clones into `~/.dotfiles`, moves conflicting files to `~/.dotfiles-backup/<timestamp>/`,
checks out, then runs `dot setup` (fisher plugins, Omarchy shell plugins).
Pushes go over SSH (`git@github.com:seagleNet/dotfiles.git`).

Prerequisites: `git curl jq fish` (install fish first so fisher plugins get set up).

Then install the tools the configs expect:

```bash
arch-setup      # Arch, WSL, Omarchy (pacman)
debian-setup    # Debian trixie+ (apt, plus upstream nvim in /opt, npm and go for the rest)
```

Then `bw login && dot secrets pull`, and copy or create an SSH key for pushing.

## Daily use

```bash
dot status
dot add ~/.config/ghostty/config     # start tracking a file
dot commit -m "..." && dot push
dot pull                             # on other machines
dot setup                            # re-run after changing fish_plugins / omarchy plugin list
```

## Private config (Bitwarden)

Nothing private is committed. Private parts sit in untracked files that the
public configs include, and are stored as Bitwarden secure notes named
`dotfiles/<name>`:

| name             | file                    | included by                             |
| ---------------- | ----------------------- | --------------------------------------- |
| `ssh-private`    | `~/.ssh/config.d/private` | `~/.ssh/config` (`Include config.d/*`) |
| `ssh-work`       | `~/.ssh/config.d/work`  | `~/.ssh/config` (`Include config.d/*`)  |
| `gitconfig-work` | `~/.gitconfig-work`     | `~/.gitconfig` (`includeIf gitdir:~/Work/`) |
| `bashrc-work`    | `~/.bashrc_work`        | `~/.bashrc` (on the work host only)     |

```bash
bw login                   # once per machine
dot secrets status
dot secrets pull           # Bitwarden -> files (all, or: dot secrets pull ssh-private)
dot secrets push           # files -> Bitwarden after editing locally
```

These paths are listed in the repo's `info/exclude`, so `dot add` refuses them.
Missing files are fine — every include is optional.

## Per-machine differences

Handled at runtime, not with templates:

- fish/bash check for tools (`bat` vs `batcat`, `fd` vs `fdfind`, WSL via `wslinfo`)
- `~/.config/hypr/monitors.lua` is intentionally untracked (differs per machine)
- Omarchy-generated files (nvim theme symlink, `fish_variables`, fisher-installed
  plugin files, generated completions) are not tracked
