@echo off
setlocal
set "pdftk_jar=%~dp0pdftk.jar"

where /q java 
if %ERRORLEVEL% equ 1 (
	rem java not found in PATH
	if defined JAVA_HOME (
		"%JAVA_HOME%\bin\java" "-jar" "%pdftk_jar%" "%*"
	) else (
		echo Java Runtime not found in PATH and JAVA_HOME is not defined.
	)
) else (
	rem java found in PATH
	java -jar "%pdftk_jar%" "%*"
)
endlocal