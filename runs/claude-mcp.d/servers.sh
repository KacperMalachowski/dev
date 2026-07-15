# shellcheck shell=bash
# MCP servers registered by runs/claude-mcp.

# GitHub Copilot MCP (public github.com) — token from GITHUB_TOKEN env or gh CLI
GITHUB_TOKEN="${GITHUB_TOKEN:-$(gh auth token 2>/dev/null)}"
if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "No GitHub token found (set GITHUB_TOKEN or run 'gh auth login') — skipping githubcom."
else
    register_remote_mcp "http" "githubcom" \
        "https://api.githubcopilot.com/mcp/" \
        "Authorization: Bearer ${GITHUB_TOKEN}"
fi

register_stdio_mcp "context7" npx -y @upstash/context7-mcp
register_stdio_mcp "drawio" npx -y @drawio/mcp@1.4.0

register_remote_mcp "sse" "cloudflare" "https://mcp.cloudflare.com/mcp"
register_remote_mcp "sse" "opentofu" "https://mcp.opentofu.org/sse"
register_stdio_mcp "sequential-thinking" npx -y @modelcontextprotocol/server-sequential-thinking
