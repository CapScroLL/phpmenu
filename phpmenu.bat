@ECHO OFF

REM Author : AVONTURE Christophe

setlocal enabledelayedexpansion enableextensions

REM Define global variables
SET BATCH=%~n0%~x0

CLS

ECHO =======================================
ECHO = PHPMENU                             =
ECHO = Which scripts do you want to start? =
ECHO =======================================
ECHO.

IF "%1"=="/?" GOTO :HELP
if "%1"=="-?" GOTO :HELP
if "%1"=="-h" GOTO :HELP

REM Check the if the script was called with a parameter and
REM in that case, this parameter is the name of a folder to scan
REM (scanOnlyFolderName will be empty or f.i. equal to "classes", a folder name)
SET scanOnlyFolderName=%1

REM Get the folder of this current script.
REM Suppose that the .php-cs configuration file can be retrieved
REM from the current "script" folder which can be different of the
REM current working directory
SET ScriptFolder=%~dp0

:MENU

IF "%scanOnlyFolderName%" NEQ "" (
	ECHO *** Scripts will be fired only for folder %scanOnlyFolderName% ***
)

IF "%scanOnlyFolderName%" EQU "" (
   ECHO Tip: need to scan only one folder? Call phpmenu with the foldername like this: "phpmenu Myclasses"
)

ECHO.

ECHO   Scan tools
ECHO     1. Start PHAN (Phan is a static analyzer for PHP) shortcut: phan.bat %scanOnlyFolderName%
ECHO     2. Start PHPStan (PHP Static Analysis Tool) shortcut: phpstan.bat %scanOnlyFolderName%
ECHO     3. Start PHPCPD (PHP Copy/Paste detector) shortcut: phpcpd.bat %scanOnlyFolderName%
ECHO     4. Start PHPCS (Start PHP_CodeSniffer, detect and show remaining errors) shortcut: phpcs.bat %scanOnlyFolderName%
ECHO     5. Start PHPMD (Start PHP Mess Detector) shortcut: phpmd.bat %scanOnlyFolderName%
ECHO     6. Start PHPMND (Start PHP Magical Number) shortcut: phpmnd.bat
ECHO     7. Start PHP Metrics (Start Static analysis tool for PHP) shortcut: phpmetrics.bat
ECHO.
ECHO   Testing tools
ECHO     8. Start PHPUNIT (PHP Unit tests) shortcut: phpunit.bat
ECHO.
ECHO   Fixed standard violation
ECHO     9. Start PHPCBF (Start PHP_CodeSniffer automatic fixer) shortcut: phpcbf.bat %scanOnlyFolderName%
ECHO    10. Start PHP-CS-FIXER (Start PHP-CS-FIXER, detect and show remaining errors) shortcut: php-cs-fixer.bat %scanOnlyFolderName%
ECHO.
ECHO   Statistics
ECHO    11. Start PHPLOC (Tool for quickly measuring the size of a PHP project) shortcut: phploc.bat %scanOnlyFolderName%
ECHO.
ECHO   Documentation
ECHO    20. Start PHPLOC (Tool for quickly measuring the size of a PHP project) shortcut: phploc.bat %scanOnlyFolderName%
ECHO.
ECHO  0. Exit
ECHO.

SET /P answer="Please make a choice? " 0-20

REM IF /I for case insensitive check
IF /I "%answer%"=="1" GOTO :PHAN
IF /I "%answer%"=="2" GOTO :PHPSTAN
IF /I "%answer%"=="3" GOTO :PHPCPD
IF /I "%answer%"=="4" GOTO :PHPCS
IF /I "%answer%"=="5" GOTO :PHPMD
IF /I "%answer%"=="6" GOTO :PHPMND
IF /I "%answer%"=="7" GOTO :PHPMETRICS
IF /I "%answer%"=="8" GOTO :PHPUNIT
IF /I "%answer%"=="9" GOTO :PHPCBF
IF /I "%answer%"=="10" GOTO :PHPCSFIXER
IF /I "%answer%"=="11" GOTO :PHPLOC
IF /I "%answer%"=="20" GOTO :PHPDOC

GOTO :END

:PHAN
CLS
CALL %ScriptFolder%\phan.bat %scanOnlyFolderName%
GOTO :END

:PHPSTAN
CLS
CALL %ScriptFolder%\phpstan.bat %scanOnlyFolderName%
GOTO :END

:PHPCPD
CLS
CALL %ScriptFolder%\phpcpd.bat %scanOnlyFolderName%
GOTO :END

:PHPCS
CLS
CALL %ScriptFolder%\phpcs.bat %scanOnlyFolderName%
GOTO :END

:PHPMD
CLS
CALL %ScriptFolder%\phpmd.bat %scanOnlyFolderName%
GOTO :END

:PHPMND
CLS
CALL %ScriptFolder%\phpmnd.bat
GOTO :END

:PHPMETRICS
CLS
CALL %ScriptFolder%\phpmetrics.bat
GOTO :END

:PHPUNIT
CLS
CALL %ScriptFolder%\phpunit.bat
GOTO :END

:PHPCBF
CLS
CALL %ScriptFolder%\phpcbf.bat %scanOnlyFolderName%
GOTO :END

:PHPCSFIXER
CLS
CALL %ScriptFolder%\php-cs-fixer.bat %scanOnlyFolderName%
GOTO :END

:PHPLOC
CLS
CALL %ScriptFolder%\phploc.bat %scanOnlyFolderName%
GOTO :END

:PHPDOC
CLS
CALL %ScriptFolder%\phpdoc.bat %scanOnlyFolderName%
GOTO :END

::--------------------------------------------------------
::-- Show help instructions
::--------------------------------------------------------
:HELP

ECHO %BATCH% [-h] [foldername]
ECHO.
ECHO -h : to get this screen
ECHO.
ECHO foldername : if you want to process all subfolders of your project, don't
ECHO specify a foldername. If you want to scan only one, mention his name like,
ECHO for instance, "%BATCH% Classes" for processing only the Classes folder (case
ECHO not sensitive).
ECHO.

GOTO END:

:END
