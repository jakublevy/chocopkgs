@echo off
echo %PSModulePath% | findstr %userprofile% >nul
if %errorlevel% neq 0 goto :isPowershellCore
echo %PSModulePath% | findstr /R /I /C:"powershell\\[1-9][0-9]*\\Modules" >nul
if %errorlevel% neq 0 goto :isPowershell

:isPowershellCore
where pwsh >nul 2>&1
if %errorlevel% neq 0 goto :isPowershell
pwsh -NoProfile -ExecutionPolicy Unrestricted -Command "& $env:ChocolateyInstall'\bin\winfetch.ps1' %*"
exit /b

:isPowershell
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& $env:ChocolateyInstall'\bin\winfetch.ps1' %*"
