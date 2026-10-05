# Dry run: feeds each hook the JSON Claude Code would send, without needing Claude.
# Usage (from this directory): powershell -NoProfile -ExecutionPolicy Bypass -File test-hooks.ps1
$failed = 0

function Test-Hook($name, $script, $json, $expectExit) {
    # Hook stderr (the message Claude would see) is discarded; only the exit code is checked.
    $json | cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File $script 2>nul" | Out-Null
    $ok = ($LASTEXITCODE -eq $expectExit)
    if (-not $ok) { $script:failed++ }
    '{0,-4} {1} (exit {2}, expected {3})' -f $(if ($ok) { 'PASS' } else { 'FAIL' }), $name, $LASTEXITCODE, $expectExit
}

function Bash-Json($cmd) { @{ tool_name = 'Bash'; tool_input = @{ command = $cmd } } | ConvertTo-Json -Compress }
function Edit-Json($path) { @{ tool_name = 'Edit'; tool_input = @{ file_path = (Resolve-Path $path).Path } } | ConvertTo-Json -Compress }

Test-Hook 'allow  git status'               hooks/guard-bash.ps1 (Bash-Json 'git status') 0
Test-Hook 'allow  force-with-lease'         hooks/guard-bash.ps1 (Bash-Json 'git push --force-with-lease origin feature') 0
Test-Hook 'block  git push --force'         hooks/guard-bash.ps1 (Bash-Json 'git push origin main --force') 2
Test-Hook 'block  git reset --hard'         hooks/guard-bash.ps1 (Bash-Json 'git reset --hard HEAD~3') 2
Test-Hook 'block  rm -rf'                   hooks/guard-bash.ps1 (Bash-Json 'rm -rf build/') 2
Test-Hook 'block  terraform apply'          hooks/guard-bash.ps1 (Bash-Json 'terraform apply -auto-approve') 2
Test-Hook 'allow  terraform plan'           hooks/guard-bash.ps1 (Bash-Json 'terraform plan') 0
Test-Hook 'clean  src/buffer_utils.cpp (32/64)' hooks/check-32-64.ps1 (Edit-Json 'src/buffer_utils.cpp') 0
Test-Hook 'risky  sample/risky.cpp (32/64)' hooks/check-32-64.ps1 (Edit-Json 'sample/risky.cpp') 2
# The syntax hook skips silently without a compiler, so these tests are only meaningful when one is on PATH.
$compiler = 'cl', 'clang++', 'g++' | Where-Object { Get-Command $_ -ErrorAction SilentlyContinue } | Select-Object -First 1
if ($compiler) {
    Test-Hook "clean  src/buffer_utils.cpp (syntax, $compiler)" hooks/syntax-check.ps1 (Edit-Json 'src/buffer_utils.cpp') 0
    Test-Hook "broken sample/broken.cpp (syntax, $compiler)" hooks/syntax-check.ps1 (Edit-Json 'sample/broken.cpp') 2
} else {
    Write-Host 'SKIP syntax-check tests: no cl, clang++ or g++ on PATH (the hook also skips silently).'
}

if ($failed -gt 0) { Write-Host "$failed test(s) failed"; exit 1 }
Write-Host 'All hook tests passed'
