@echo off
setlocal enabledelayedexpansion

:: Check if compiler is in PATH, otherwise add LLVM-MinGW
where cl.exe >nul 2>&1
if %ERRORLEVEL% equ 0 goto compile_msvc

where clang++ >nul 2>&1
if %ERRORLEVEL% equ 0 goto compile_clang

where g++ >nul 2>&1
if %ERRORLEVEL% equ 0 goto compile_gxx

if exist "%LOCALAPPDATA%\Microsoft\WinGet\Packages\MartinStorsjo.LLVM-MinGW.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\llvm-mingw-20260616-ucrt-x86_64\bin\clang++.exe" (
    set "PATH=%LOCALAPPDATA%\Microsoft\WinGet\Packages\MartinStorsjo.LLVM-MinGW.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\llvm-mingw-20260616-ucrt-x86_64\bin;%PATH%"
    goto compile_clang
)

echo [ERROR] No C++ compiler found on Windows.
exit /b 1

:compile_msvc
echo [MSVC] Compiling Demo 03...
cl /nologo /std:c++17 /W4 /EHsc /Iinclude src\range_check.cpp tests\range_check_test.cpp /Fe:range_check_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Running range_check_test.exe...
range_check_test.exe
exit /b %ERRORLEVEL%

:compile_clang
echo [Clang/Windows] Compiling Demo 03...
clang++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude src/range_check.cpp tests/range_check_test.cpp -o range_check_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Running range_check_test.exe...
range_check_test.exe
exit /b %ERRORLEVEL%

:compile_gxx
echo [G++/Windows] Compiling Demo 03...
g++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude src/range_check.cpp tests/range_check_test.cpp -o range_check_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Running range_check_test.exe...
range_check_test.exe
exit /b %ERRORLEVEL%
