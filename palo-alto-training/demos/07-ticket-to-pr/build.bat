@echo off
setlocal

:: Compiler detection: MSVC, then Clang, then g++, then the WinGet LLVM-MinGW install.
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
echo [MSVC] Compiling Demo 07...
cl /nologo /std:c++17 /W4 /WX /EHsc /Iinclude src\port_ranges.cpp tests\port_ranges_test.cpp /Fe:port_ranges_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
port_ranges_test.exe
exit /b %ERRORLEVEL%

:compile_clang
echo [Clang/Windows] Compiling Demo 07...
clang++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude src/port_ranges.cpp tests/port_ranges_test.cpp -o port_ranges_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
port_ranges_test.exe
exit /b %ERRORLEVEL%

:compile_gxx
echo [G++/Windows] Compiling Demo 07...
g++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude src/port_ranges.cpp tests/port_ranges_test.cpp -o port_ranges_test.exe
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
port_ranges_test.exe
exit /b %ERRORLEVEL%
