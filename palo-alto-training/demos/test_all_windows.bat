@echo off
setlocal

echo ===================================================
echo [Palo Alto Workshop] Testing All Demos on Windows
echo ===================================================

:: Ensure compiler bin directory is in PATH
if exist "%LOCALAPPDATA%\Microsoft\WinGet\Packages\MartinStorsjo.LLVM-MinGW.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\llvm-mingw-20260616-ucrt-x86_64\bin\clang++.exe" (
    set "PATH=%LOCALAPPDATA%\Microsoft\WinGet\Packages\MartinStorsjo.LLVM-MinGW.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\llvm-mingw-20260616-ucrt-x86_64\bin;%PATH%"
)

echo.
echo --- [1/4] Demo 02 Noisy CI / RTK (C++ and Go) ---
cd 02-noisy-ci-rtk\cpp
call build.bat
if exist noisy_ci.exe del /q /f noisy_ci.exe
cd ..\go
go run ./cmd/noisy-ci --mode compare
cd ..\..

echo.
echo --- [2/4] Demo 03 Ponytail (64-bit and 32-bit C++) ---
cd 03-ponytail
call build.bat
if exist range_check_test.exe del /q /f range_check_test.exe
cd ..

echo.
echo --- [3/4] Demo 04 Contract vs Prompt (C++ and Go) ---
cd 04-contract-vs-prompt\cpp
call build.bat
if exist deployment_gate_test.exe del /q /f deployment_gate_test.exe
cd ..\go
go test -v ./...
cd ..\..

echo.
echo --- [4/4] Demo 05 Rules and Guardrails (C++ and Go) ---
cd 05-rules-and-guardrails\cpp
call build.bat
if exist retry_policy_test.exe del /q /f retry_policy_test.exe
cd ..\go
go test -v ./...
cd ..\..

echo.
echo ===================================================
echo [SUCCESS] All C++ and Go tests completed on Windows!
echo ===================================================
