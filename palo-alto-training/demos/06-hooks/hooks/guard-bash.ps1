# PreToolUse hook (matcher: Bash). Blocks destructive commands before Claude runs them.
# Claude Code sends the tool call as JSON on stdin. Exit 2 blocks the call and sends stderr back to Claude.
$payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
$cmd = [string]$payload.tool_input.command

$rules = @(
    @{ Pattern = 'git\s+push\b.*\s(--force|-f)(\s|$)'; Reason = 'Force-push rewrites shared history. Use --force-with-lease on your own branch after asking the user.' },
    @{ Pattern = 'git\s+reset\s+--hard';               Reason = 'git reset --hard discards uncommitted work. Use git stash or ask the user.' },
    @{ Pattern = '\brm\s+-[a-z]*r[a-z]*f|\bRemove-Item\b.*-Recurse.*-Force'; Reason = 'Recursive forced delete. Name the exact paths and ask the user first.' },
    @{ Pattern = 'terraform\s+(apply|destroy)\b';      Reason = 'Terraform apply/destroy changes real infrastructure. Run terraform plan and let a human apply.' }
)

foreach ($rule in $rules) {
    if ($cmd -match $rule.Pattern) {
        [Console]::Error.WriteLine("Blocked by guard-bash hook: $($rule.Reason)")
        exit 2
    }
}
exit 0
