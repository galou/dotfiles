# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). This directory *is* the chezmoi source
directory (`~/.local/share/chezmoi`, no `.chezmoiroot` redirect), and files here are transformed by
chezmoi's naming/templating rules before being applied to the user's `$HOME`. There is no build step and
no test suite — the "correctness" check is `chezmoi diff` / `chezmoi apply` against a real machine.

## Commands

- `chezmoi diff` — show what would change in `$HOME` if applied. Run this after editing any source file to
  sanity-check the rendered output before applying.
- `chezmoi apply` — apply the source state to `$HOME`. Only do this if asked; it mutates the user's real
  dotfiles/config on the current machine.
- `chezmoi edit ~/<path>` — open the source file corresponding to a target path.
- `chezmoi cd` — cd into the source directory (this repo).
- `chezmoi source status` — like `git status` but chezmoi-aware.
- `chezmoi execute-template < file.tmpl` — render a single template snippet standalone, useful for checking
  Go-template syntax in a `.tmpl` file without applying anything.
- `chezmoi chattr executable ~/<path>` — toggle the executable attribute on a managed file (adds/removes the
  `executable_` source prefix).

There is no linter or formatter configured for this repo; shell scripts and configs are hand-maintained.

## Naming conventions (chezmoi source-state attributes)

File/dir names encode how chezmoi maps them into `$HOME`:

- `dot_foo` → `~/.foo`, `private_dot_foo` → `~/.foo` created with `0600`/`0700` perms (used for anything
  under `~/.config` or `~/.local` that may contain secrets).
- `executable_foo` → file is marked executable at the target.
- `*.tmpl` → rendered through Go templates using the data in `.chezmoi.yaml.tmpl` before being written (the
  `.tmpl` suffix is stripped from the target name).

When adding a new managed file, follow the existing convention in the sibling files of that directory
(most things under `private_dot_config/` and `private_dot_local/` use `private_dot_`; top-level dotfiles use
plain `dot_`).

## Template data and secrets

`.chezmoi.yaml.tmpl` defines the `data:` map available to every `.tmpl` file. It detects `chassis_type`
(laptop/desktop) at apply time via `hostnamectl`/`sysctl`/PowerShell depending on OS, and declares (empty)
slots for machine-specific values (monitor names, network device names) and for API keys/secrets
(`anthropic`, `borg`, `github`, `openai`, `gemini`, etc.). Actual secret values are **not** stored in this
repo — they live in the user's local `~/.config/chezmoi/chezmoi.yaml` (see `README.rst`) and are merged
into `.` at apply time.

Because these keys are optional/per-machine, templates must guard every optional secret access, e.g.:

```
{{- if (and (index . "openai") (index .openai "api_key"))}}
export OPENAI_API_KEY='{{.openai.api_key}}'
{{- end}}
```

Follow this `(index . "x")` guard pattern (see `private_dot_config/shell/profile.tmpl` and
`private_dot_config/zsh/dot_zshrc.tmpl`) rather than assuming a key is present — most machines only set a
subset of the keys declared in `.chezmoi.yaml.tmpl`.

`.chezmoiignore` conditionally excludes files based on `.chassis_type` and `.chezmoi.hostname` (e.g.
laptop-only scripts, or `.Xresources` only applying on host `pcgael4`). When adding host- or
chassis-conditional files, add the matching guard there rather than relying on the file simply not existing
on other machines.

## Shell configuration layering

Login/interactive shell setup is layered and shared between bash and zsh:

- `dot_zshenv` sets `ZDOTDIR=$HOME/.config/zsh` (zsh) before zsh reads any other rc file.
- `dot_bashrc` (bash) and `private_dot_config/zsh/dot_zshrc.tmpl` (zsh, under `ZDOTDIR`) both source the
  same shared files: `~/.config/shell/profile` (built from `profile.tmpl`) and `~/.config/shell/shell_aliases`
  (built from `shell_aliases.tmpl`), plus zsh has its own `zsh_aliases.tmpl`.
- `profile.tmpl` is the common cross-shell POSIX-sh file: PATH/LD_LIBRARY_PATH/XDG_DATA_DIRS helpers, tool
  activation functions (conda, PlatformIO, openrobots...), ROS helpers, and the guarded secret exports
  described above. Keep additions here POSIX-sh compatible (it's sourced by both bash and zsh), not
  zsh-specific syntax — put zsh-only things in `zsh_aliases.tmpl`/`dot_zshrc.tmpl` instead.

## Other notable pieces

- `06-common/it/post-install-pop24.sh.tmpl` — a standalone post-install script (not a dotfile) rendered to
  `~/06-common/it/post-install-pop24.sh`, meant to be run manually once after a fresh Pop!_OS install
  (`bash ./post-install-pop24.sh`, not as root). It uses `{{/* comment */}}` template comments purely as
  inline documentation next to `apt install` package names — check these comments when adding/removing
  packages so the reason for each package stays attached to it.
- Per-window-manager/app configs live under `private_dot_config/<app>/` (sway, i3, waybar, kitty, zellij,
  etc.) each with their own `.tmpl` files following the same guarded-template conventions as above.
