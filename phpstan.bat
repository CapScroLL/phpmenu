@ECHO OFF

setlocal enabledelayedexpansion enableextensions

REM ------------------------------------------------------------
REM - PHP-STAN - Start PHPSTAN (PHP Static Analysis Tool) on   -
REM - each subfolder of the current working                    -
REM - @see https://github.com/phpstan/phpstan                  -
REM ------------------------------------------------------------

CLS

ECHO ===========================================
ECHO = Running PHPSTAN                         =
ECHO = PHP Static Analysis Tool                =
ECHO = @see https://github.com/phpstan/phpstan =
ECHO ===========================================
ECHO.

IF "%1"=="/?" GOTO :HELP
if "%1"=="-?" GOTO :HELP
if "%1"=="-h" GOTO :HELP

REM Check the if the script was called with a parameter and
REM in that case, this parameter is the name of a folder to scan
REM (scanFolderName will be empty or f.i. equal to "classes", a folder name)
SET scanFolderName=%cd%
IF "%1" NEQ "" (
	REM %1 is a foldername like "classes" (relative name); make it absolute
	SET scanFolderName=%cd%\%1
)


REM Get the folder of this current script.
REM Suppose that the ruleset.xml configuration file can be retrieved
REM from the current "script" folder which can be different of the
REM current working directory
SET ScriptFolder=%~dp0

REM For phpstan, check if we've a file phpstan.neon in the current
REM working directory i.e. the one of the project phpstan.neon
REM If so, use that configuration file.
REM If not, use the phpstan.neon present in the folder of the phpstan.bat
REM script
SET configFile=%cd%\phpstan.neon
IF NOT EXIST %configFile% (
    SET configFile=%ScriptFolder%phpstan.neon
)

REM Process the folder
CALL :fnProcessFolder %scanFolderName%

GOTO END:

::--------------------------------------------------------
::-- fnProcessFolder - Process a given folder
::--------------------------------------------------------
:fnProcessFolder

ECHO Process folder %1
ECHO.

REM Be sure that PHPSTAN (https://github.com/phpstan/phpstan)
REM has been installed globally by using, first,
REM composer global require phpstan/phpstan
REM If not, php-cs-fixer won't be retrieved in the %APPDATA% folder

REM --level max is the highest control level (0 is the loosest and 7 is the strictest)
REM is https://github.com/phpstan/phpstan#rule-levels

REM ECHO Command line options are
ECHO     %1 (scanned folder)
ECHO     --level max (max level of checks)
ECHO     -c %configFile% (configuration file used)
ECHO.

CALL %APPDATA%\Composer\vendor\bin\phpstan analyze %1 --level max -c %configFile%

GOTO:EOF

::--------------------------------------------------------
::-- Show help instructions
::--------------------------------------------------------
:HELP

ECHO phpstan.bat [-h] [foldername]
ECHO.
ECHO -h : to get this screen
ECHO.
ECHO foldername : if you want to scan all subfolders of your project, don't
ECHO specify a foldername. If you want to scan only one, mention his name like,
ECHO for instance, "phpstan.bat Classes" for scanning only the Classes folder (case
ECHO not sensitive).
ECHO.
ECHO Remarks
ECHO -------
ECHO.
ECHO If you want to use your own configuration file; create a phpstan.neon file
ECHO in your project's folder.

GOTO END:

:END
ECHO.
ECHO End
