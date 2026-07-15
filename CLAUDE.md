# dev — personal dev-environment bootstrapper (public base)

Kacper's **public, personal** dev-environment: shell config, tooling installs,
and Claude Code setup. This repo is shared across all of Kacper's machines and
is consumed as a submodule by machine-specific supersets (e.g. a work repo
that overlays employer-specific config on top).

## Layout

```
.
├── env/                  # dotfiles: zsh, tmux, nvim, git, and .config/.ai (skills/agents)
│   └── .config/.ai/      # submodule: github.com/KacperMalachowski/.ai — Claude Code skills/agents
├── runs/                 # tool INSTALL steps only (claude-code, docker, gcloud, nvim, …)
├── run                   # dispatcher: executes each executable in runs/
├── dev-env               # copies dotfiles into place, then invokes env/.config/.ai/build
├── setup / init          # entrypoints
```

## Responsibilities (important distinction)

- **`runs/`** — purely tool *installation* (install a CLI if missing). No file copying.
- **`dev-env`** — the *setup* script that copies config files into `$XDG_CONFIG_HOME`/`$HOME`, then builds the Claude Code config from the `.ai` submodule.

## Claude Code config

Skills, agents, and the global `CLAUDE.md` come from the `env/.config/.ai`
submodule (`KacperMalachowski/.ai`), which has a `base/` + `overlays/` structure
and its own `build`. This repo does not deploy `~/.claude/commands` directly.

## Scope

Keep this repo **generic and public** — no employer-specific hosts, tokens,
project identifiers, or internal tooling. Anything work-specific belongs in a
downstream overlay, not here.

## Conventions

- Never commit without an explicit order.
- Scripts run under `set -euo pipefail` and must pass shellcheck (`runs/shellcheck` installs it; `.shellcheckrc` configures it).
- `main` is protected — changes normally go through a PR.
