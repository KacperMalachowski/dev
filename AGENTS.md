# Public dev-environment base

- Read `CLAUDE.md` for layout, script conventions, and public/private boundaries.
- OpenCode is the default AI client; `AI_CLIENT=claude|both` opts into compatibility.
- Keep installs in `runs/`, deployment in `dev-env` and the `.ai` submodule build.
- Keep employer-specific content out of this repository.
- Preserve existing user changes. No commits without an explicit order.
- Scripts use `set -euo pipefail` and must pass ShellCheck.
