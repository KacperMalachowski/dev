# Public dev-environment base

- Read `CLAUDE.md` for layout, script conventions, and public/private boundaries.
- Claude Code is the only AI client; its config comes from the `.ai` submodule build.
- Keep installs in `runs/`, deployment in `dev-env` and the `.ai` submodule build.
- Keep employer-specific content out of this repository.
- Preserve existing user changes. No commits without an explicit order.
- Scripts use `set -euo pipefail` and must pass ShellCheck.
