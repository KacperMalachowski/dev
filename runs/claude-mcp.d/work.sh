# shellcheck shell=bash
# Work-machine MCP servers.
# Sourced by runs/claude-mcp when the work overlay marker is present.

# github-tools-sap: GitHub Enterprise Server MCP for github.tools.sap.
# Uses the github-mcp-server stdio binary with GITHUB_HOST pointed at the
# internal GHES instance. Token is read from GITHUB_PERSONAL_ACCESS_TOKEN —
# we resolve it from the env var or fall back to `gh auth token --hostname`.
#
# Ensure the binary is present before registering — idempotent, no-op if
# already installed. Independent of the runs/ dispatcher iteration order.
"$SCRIPT_DIR/github-mcp-server"

if ! command -v github-mcp-server &> /dev/null; then
    echo "github-tools-sap: github-mcp-server binary still not found after install — skipping."
else
    GHES_TOOLS_TOKEN="${GITHUB_PERSONAL_ACCESS_TOKEN:-$(gh auth token --hostname github.tools.sap 2>/dev/null)}"
    if [[ -z "$GHES_TOOLS_TOKEN" ]]; then
        echo "github-tools-sap: no token (set GITHUB_PERSONAL_ACCESS_TOKEN or 'gh auth login --hostname github.tools.sap') — skipping."
    else
        register_stdio_mcp_with_env "github-tools-sap" \
            "GITHUB_HOST=https://github.tools.sap" \
            "GITHUB_PERSONAL_ACCESS_TOKEN=${GHES_TOOLS_TOKEN}" \
            -- github-mcp-server stdio
    fi
fi

# TODO: github-wdf-corp-sap — no MCP server available for github.wdf.corp.sap
# at the moment. Add a registration here when one becomes available.

# Corporate policy: sequential-thinking must not be installed or registered.
# Defensive cleanup if a machine ever flipped from personal to work — the npx
# package may still be cached in ~/.npm/_npx but at least the registration
# goes away so Claude Code stops invoking it.
unregister_mcp sequential-thinking
unregister_mcp cloudflare
