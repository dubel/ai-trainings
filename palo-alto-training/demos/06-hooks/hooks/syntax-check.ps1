# PostToolUse hook (matcher: Edit|Write). Syntax-only compile of the edited C++ file (nothing is linked or run).
# Uses cl.exe when the Developer Command Prompt is active, otherwise clang++ or g++. Skips quietly if none exists.
$payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
$file = [string]$payload.tool_input.file_path

if ($file -notmatch '\.(cpp|cc|cxx)$' -or -not (Test-Path -LiteralPath $file)) { exit 0 }

$inc = Join-Path (Split-Path -Parent (Split-Path -Parent $file)) 'include'

if (Get-Command cl -ErrorAction SilentlyContinue) {
    $out = & cl /nologo /std:c++17 /W4 /EHsc /Zs "/I$inc" $file 2>&1
} elseif (Get-Command clang++ -ErrorAction SilentlyContinue) {
    $out = & clang++ -std=c++17 -Wall -Wextra -fsyntax-only "-I$inc" $file 2>&1
} elseif (Get-Command g++ -ErrorAction SilentlyContinue) {
    $out = & g++ -std=c++17 -Wall -Wextra -fsyntax-only "-I$inc" $file 2>&1
} else {
    exit 0
}

if ($LASTEXITCODE -ne 0) {
    [Console]::Error.WriteLine("syntax-check hook: $file does not compile (C++17):`n" + ($out -join "`n"))
    exit 2
}
exit 0
