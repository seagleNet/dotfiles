# dotfiles

Personal config for Arch (incl. WSL), Omarchy and Debian machines: fish, bash,
vim/neovim, starship, git, ssh, ghostty and Omarchy/Hyprland overrides.

Files live at their normal location in `$HOME` — this is a bare git repo in
`~/.dotfiles` with `$HOME` as work tree, driven by the
[`dot`](../.local/bin/dot) wrapper. Edit configs in place, then `dot add` /
`dot commit` / `dot push`. Untracked files are hidden, so `dot status` only
shows tracked changes.

## New machine

1. **Prerequisites** — git, curl and mise; `dot bootstrap` uses mise to install
   everything else:

   ```bash
   # Arch / WSL (Omarchy: already there)
   sudo pacman -S --needed git curl mise
   # Debian
   sudo apt install git curl
   curl -fsSL https://mise.run | sh
   ```

2. **Bootstrap**

   ```bash
   repo=https://raw.githubusercontent.com/seagleNet/dotfiles/master
   curl -fsSL "$repo/.local/bin/dot" | bash -s -- bootstrap
   ```

   Clones into `~/.dotfiles` over HTTPS, moves files that would be overwritten
   to `~/.dotfiles-backup/<timestamp>/` and checks out. Then `mise bootstrap`
   installs the packages and tools from `~/.config/mise/conf.d/bootstrap/`, and
   `dot setup` adds the pre-commit hook and fisher plugins (on Omarchy also the
   shell plugins from `~/.config/dotfiles/omarchy-plugins` and the font). Pushes
   go over SSH.

   Packages come from pacman or apt. On Arch they're current, so tools come
   from pacman too; on Debian, which ships many too old, `dot` selects the
   `debian` mise module (`~/.config/mise/miserc.local.toml`, per machine) and
   mise installs them from upstream instead. odin and ols come from mise
   everywhere.

3. **Open a new shell** so `~/.local/bin` and the mise tools are on `PATH`.
   Optionally `chsh -s /usr/bin/fish`. Then `gh auth login`: mise uses its
   token for GitHub downloads, unauthenticated it's limited to 60 requests an
   hour.

4. **Keeping up to date** — `omarchy update` on Omarchy (system packages,
   `mise up`, and a post-update hook for ols nightly), `mise run update`
   everywhere else.

5. **Bitwarden CLI** — use the standalone build: Arch's `bitwarden-cli`
   package needs `nodejs-lts-*`, which conflicts with `nodejs`.

   ```bash
   # Omarchy (or: yay -S bitwarden-cli-bin)
   omarchy pkg aur add bitwarden-cli-bin
   # Debian
   curl -fsSLo /tmp/bw.zip \
     "https://vault.bitwarden.com/download/?app=cli&platform=linux"
   unzip -o /tmp/bw.zip -d ~/.local/bin && chmod +x ~/.local/bin/bw
   ```

6. **Private config**

   ```bash
   dot secrets pull             # all of them, runs `bw login` on first use
   dot secrets pull ssh-private # or only what this machine needs
   ```

7. **SSH key** — private keys aren't part of the dotfiles. Copy them over or
   create a new one and add it to GitHub; it's needed for `dot push`.

8. **Per machine** — on Omarchy, adjust the untracked
   `~/.config/hypr/monitors.lua`. Neovim installs its plugins on first start,
   pinned by `lazy-lock.json`.

## Daily use

```bash
dot status
dot add ~/.config/ghostty/config # start tracking a file
dot commit -m "..." && dot push
dot ai-commit                    # or let Claude write the message, opened for review
dot pull                         # on other machines
dot setup                        # after changing fish_plugins / plugin list / font
```

`dot ai-commit` (alias `aic`) sends the staged diff and the last 30 commit
messages to `claude -p` with all tools disabled, and opens the suggested
message in your editor; save to commit, empty it to abort. Extra arguments go
to `git commit` (`--no-edit` commits without review). The denylist check from
the pre-commit hook runs before anything is sent. `DOT_AI_MODEL` picks the
model (default `sonnet`).

## Private config (Bitwarden)

Nothing private is committed. Private parts sit in untracked files that the
public configs include (`~/.ssh/config` has `Include config.d/*`,
`~/.gitconfig` an `includeIf gitdir:~/Work/`, `~/.bashrc` sources
`~/.bashrc_work`, which checks for the work host itself).

The files are listed in [`~/.config/dotfiles/secrets`](../.config/dotfiles/secrets)
— one `<name> <path>` per line, only names and paths, so it's safe to commit.
Each file is stored as a Bitwarden secure note named `dotfiles/<name>`. Text
files up to 7000 bytes go into the note itself; larger or binary files become
an attachment on that note (needs Premium), with the note holding a checksum
so `push` skips unchanged files and `pull` verifies downloads.

```bash
dot secrets list   # configured secrets, local only (no Bitwarden access)
dot secrets status # compare with Bitwarden: in sync, differs, missing, ...
                   # (any Bitwarden command logs in first if this machine isn't)
dot secrets pull   # Bitwarden -> files (all, or name them)
dot secrets push   # files -> Bitwarden after editing locally

# register a new secret: appends to the list, excludes it from git, pushes it
dot secrets add ssh-key ~/.ssh/id_ed25519
# unregister: moves the item to the Bitwarden trash (restorable for 30 days),
# keeps the local file; --keep-vault leaves Bitwarden alone
dot secrets rm ssh-key
```

Aliases: `dot secret` for `dot secrets`, `ls` for `list`, `remove` for `rm`,
`st` for `status`.

`status` compares notes by content and attachments by their checksum, so it
downloads nothing. It can't know which side changed (there's no sync history),
so a mismatch shows as `differs`: push if you edited the file here, pull if it
was updated from another machine.

After `dot secrets add`, commit `~/.config/dotfiles/secrets`; other machines then
`dot pull` and `dot secrets pull <name>`. When editing the list by hand, run
`dot setup` to update the git excludes.

For speed, each `dot secrets` run starts one `bw serve` on a unix socket in a
private directory (only your user can connect; falls back to `127.0.0.1` if
the installed `bw` can't do that) and talks to it with `curl`, instead of
starting `bw` for every step. It's stopped when `dot` exits.

Each `dot secrets` run asks for the master password. To unlock once per shell:

```bash
set -gx BW_SESSION (bw unlock --raw) # fish
export BW_SESSION=$(bw unlock --raw) # bash
```

These paths are listed in the repo's `info/exclude`, so `dot add` refuses them.
Missing files are fine — every include is optional.

## Leak checks

- **pre-commit hook** (installed by `dot setup`): blocks commits whose added
  lines match a regex in the private `~/.config/dotfiles/denylist` (work
  domains, LAN addresses, …). Does nothing on machines without the list.
- **GitHub Actions** (`.github/workflows/check.yml`): gitleaks over the full
  history, shellcheck for the shell scripts and dotfiles, `fish -n` for all
  fish files.

## Per-machine differences

Handled at runtime, not with templates:

- fish/bash check for tools (`bat` vs `batcat`, `fd` vs `fdfind`, WSL via
  `wslinfo`)
- PATH setup is shared by `.profile` and `.bashrc` via
  `~/.config/shell/path.sh` (fish has the same list in `config.fish`)
- `~/.config/hypr/monitors.lua` is intentionally untracked (differs per
  machine)
- Omarchy-generated files (nvim theme symlink, `fish_variables`,
  fisher-installed plugin files, generated completions) are not tracked
