# shellcheck shell=bash
# Helpers for claude-mcp profile scripts.
# Sourced — not executed. Mark this file non-executable so the runs/ dispatcher
# (run script) skips it when iterating executables.

# Run `claude mcp add` without letting a single failure abort the whole run.
# Some servers are refused by enterprise policy ("explicitly blocked by
# enterprise policy") on managed machines; that must not stop the remaining
# servers from registering under `set -e`. Returns 0 always; warns on failure.
_mcp_add() {
    local name="$1"
    shift
    if claude mcp add "$@"; then
        echo "$name: registered."
    else
        echo "$name: could not be registered (blocked or add failed) — skipping." >&2
    fi
}

register_remote_mcp() {
    local transport="$1"
    local name="$2"
    local url="$3"
    local header="$4"

    if claude mcp get "$name" &> /dev/null; then
        echo "$name: already registered, skipping."
        return
    fi

    if [[ -n "$header" ]]; then
        _mcp_add "$name" --transport "$transport" -s user "$name" "$url" --header "$header"
    else
        _mcp_add "$name" --transport "$transport" -s user "$name" "$url"
    fi
}

register_stdio_mcp() {
    local name="$1"
    shift
    local cmd=("$@")

    if claude mcp get "$name" &> /dev/null; then
        echo "$name: already registered, skipping."
        return
    fi

    _mcp_add "$name" -s user "$name" -- "${cmd[@]}"
}

# Register a stdio MCP with environment variables. Use when the server needs
# config like GITHUB_HOST or GITHUB_PERSONAL_ACCESS_TOKEN passed through to it.
# Args: name, then any number of KEY=VALUE pairs, then --, then the command.
register_stdio_mcp_with_env() {
    local name="$1"
    shift

    local env_args=()
    while [[ $# -gt 0 && "$1" != "--" ]]; do
        env_args+=(-e "$1")
        shift
    done
    [[ "$1" == "--" ]] && shift

    if claude mcp get "$name" &> /dev/null; then
        echo "$name: already registered, skipping."
        return
    fi

    _mcp_add "$name" -s user "$name" "${env_args[@]}" -- "$@"
}

# Idempotent removal — silent if the server isn't registered.
unregister_mcp() {
    local name="$1"
    if claude mcp get "$name" &> /dev/null; then
        claude mcp remove "$name" -s user &> /dev/null && echo "$name: unregistered."
    fi
}
