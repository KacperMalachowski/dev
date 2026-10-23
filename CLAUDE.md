# dev — personal dev-environment bootstrapper (public base)

Kacper's **public, personal** dev-environment: shell config, tooling installs,
and OpenCode-first AI setup. This repo is shared across all of Kacper's machines and
is consumed as a submodule by machine-specific supersets (e.g. a work repo
that overlays employer-specific config on top).

## Layout

```
.
├── env/                  # dotfiles: zsh, tmux, nvim, git, and .config/.ai (skills/agents)
│   └── .config/.ai/      # submodule: github.com/KacperMalachowski/.ai — portable skills/agents
├── runs/                 # tool INSTALL steps only (claude-code, docker, gcloud, nvim, …)
├── run                   # dispatcher: executes each executable in runs/
├── dev-env               # copies dotfiles into place, then invokes env/.config/.ai/build
├── setup / init          # entrypoints
```

## Responsibilities (important distinction)

- **`runs/`** — tool installation plus the existing MCP-registration exception (`opencode-mcp` / optional `claude-mcp`). No dotfile copying.
- **`dev-env`** — the *setup* script that copies config files into `$XDG_CONFIG_HOME`/`$HOME`, then builds the selected AI config from the `.ai` submodule. Dry runs do not build.

## AI config

Skills, agents, and the global `AGENTS.md` come from the `env/.config/.ai`
submodule (`KacperMalachowski/.ai`), which has a `base/` + `overlays/` structure
and its own `build`. Source skills and agents are vendor-neutral; deployment
adapters supply client-specific syntax. OpenCode is the default. Use `AI_CLIENT=claude` or `both`
to install/deploy Claude compatibility. Nothing uninstalls an existing Claude CLI.

## Scope

Keep this repo **generic and public** — no employer-specific hosts, tokens,
project identifiers, or internal tooling. Anything work-specific belongs in a
downstream overlay, not here.

## Conventions

- Never commit without an explicit order.
- Scripts run under `set -euo pipefail` and must pass shellcheck (`runs/shellcheck` installs it; `.shellcheckrc` configures it).
- `main` is protected — changes normally go through a PR.
