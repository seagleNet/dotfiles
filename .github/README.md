# dotfiles

Personal config for Arch (incl. WSL), Omarchy and Debian machines: fish, bash,
vim/neovim, starship, git, ssh, ghostty and Omarchy/Hyprland overrides.

Files live at their normal location in `$HOME` — this is a bare git repo in
`~/.dotfiles` with `$HOME` as work tree, driven by the [`dot`](../.local/bin/dot)
wrapper. Edit configs in place, then `dot add` / `dot commit` / `dot push`.
Untracked files are hidden, so `dot status` only shows tracked changes.

## New machine

1. **Prerequisites** — install fish before bootstrapping so `dot setup` can set up the fisher plugins:

   ```bash
   sudo pacman -S --needed git curl jq fish        # Arch / WSL (Omarchy: usually already there)
   sudo apt install git curl jq fish unzip         # Debian
   ```

2. **Bootstrap**

   ```bash
   curl -fsSL https://raw.githubusercontent.com/seagleNet/dotfiles/master/.local/bin/dot | bash -s -- bootstrap
   ```

   Clones into `~/.dotfiles` over HTTPS, moves files that would be overwritten to
   `~/.dotfiles-backup/<timestamp>/`, checks out, then runs `dot setup`
   (fisher plugins; on Omarchy also the shell plugins from
   `~/.config/dotfiles/omarchy-plugins`). Pushes go over SSH.

3. **Open a new shell** so `~/.local/bin` is on `PATH`. Optionally `chsh -s /usr/bin/fish`.

4. **Install the tools the configs expect**

   ```bash
   arch-setup      # Arch, WSL, Omarchy (pacman)
   debian-setup    # Debian trixie+ (apt, upstream nvim in /opt, npm and go for the rest)
   ```

5. **Bitwarden CLI**

   ```bash
   omarchy pkg aur add bitwarden-cli-bin           # Omarchy (or: yay -S bitwarden-cli-bin)
   curl -fsSLo /tmp/bw.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux" \
     && unzip -o /tmp/bw.zip -d ~/.local/bin && chmod +x ~/.local/bin/bw   # Debian
   ```

   Use the standalone build: Arch's `bitwarden-cli` package needs `nodejs-lts-*`,
   which conflicts with `nodejs`.

6. **Private config**

   ```bash
   bw login
   dot secrets pull                # all, or only what this machine needs: dot secrets pull ssh-private
   ```

7. **SSH key** — private keys aren't part of the dotfiles. Copy them over or create a
   new one and add it to GitHub; it's needed for `dot push`.

8. **Per machine** — on Omarchy, adjust the untracked `~/.config/hypr/monitors.lua`.
   Neovim installs its plugins on first start, pinned by `lazy-lock.json`.

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
| `bashrc-work`    | `~/.bashrc_work`        | `~/.bashrc` (the file itself checks for the work host) |

```bash
bw login                   # once per machine
dot secrets status
dot secrets pull           # Bitwarden -> files (all, or: dot secrets pull ssh-private)
dot secrets push           # files -> Bitwarden after editing locally
```

Each `dot secrets` run asks for the master password. To unlock once per shell:
`set -gx BW_SESSION (bw unlock --raw)` (fish) or `export BW_SESSION=$(bw unlock --raw)` (bash).

These paths are listed in the repo's `info/exclude`, so `dot add` refuses them.
Missing files are fine — every include is optional.

## Per-machine differences

Handled at runtime, not with templates:

- fish/bash check for tools (`bat` vs `batcat`, `fd` vs `fdfind`, WSL via `wslinfo`)
- `~/.config/hypr/monitors.lua` is intentionally untracked (differs per machine)
- Omarchy-generated files (nvim theme symlink, `fish_variables`, fisher-installed
  plugin files, generated completions) are not tracked
