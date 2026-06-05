# shellcheck shell=bash
# Personal-machine MCP servers.
# Sourced by runs/claude-mcp when no work overlay marker is present.

register_remote_mcp "sse" "cloudflare" "https://mcp.cloudflare.com/mcp"
register_stdio_mcp "sequential-thinking" npx -y @modelcontextprotocol/server-sequential-thinking

# Defensive: if a machine ever flips from work to personal (e.g. re-imaged
# without the work overlay), drop stale work registrations. Idempotent.
unregister_mcp github-tools-sap
