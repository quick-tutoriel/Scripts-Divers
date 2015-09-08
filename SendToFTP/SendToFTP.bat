@ECHO OFF
TITLE Send to FTP
ECHO Send to FTP
ECHO Written by: Jason Faulkner
ECHO JasonFaulkner.com
ECHO HowToGeek.com
ECHO.
ECHO.

REM Usage:
REM Update this file according to your connection settings and copy a shortcut to:
REM 	%UserProfile%\AppData\Roaming\Microsoft\Windows\SendTo
REM
REM Now when you select one or more files in Windows Explorer and right-click, you can select Send To > FTP Site (or whatever your shortcut is titled).
REM If you have several FTP sites you use, you can create multiple copies of this file and add as many shortcuts as needed to your Send To menu.


SETLOCAL EnableExtensions

REM Connection information:
SET Server=votre_ftp
SET UserName=votre_login
REM If you want to hardcode the password (no prompt), enter it on the first line below and leave the second line commented out (starts with REM).
REM If you want to be prompted for your password each time, comment out the first line below (start it with REM) and uncomment the second line (remove REM).
SET Password=votre_password
REM SET /P Password=Enter the password for %UserName%:


SET Commands="%TEMP%\FTPCommands_%RANDOM%.txt"

REM FTP user name and password
ECHO %UserName%> %Commands%
ECHO %Password%>> %Commands%

REM If you need the files to go to a subdirectory on your FTP site, uncomment and add lines as needed below
REM ECHO cd SubDir1 >> %Commands%
REM ECHO cd SubDir2 >> %Commands%

REM FTP transfer settings
ECHO binary >> %Commands%

:AddFiles
IF {%1}=={} GOTO CloseConnection
ECHO put "%~dpnx1" >> %Commands%
SHIFT /1
GOTO AddFiles

:CloseConnection
REM Close the FTP connection
ECHO close >> %Commands%
ECHO bye >> %Commands%

REM Perform the FTP
FTP -d -i -s:%Commands% %Server%

ECHO.
ECHO.

REM Clean up
IF EXIST %Commands% DEL %Commands%

ENDLOCAL

TIMEOUT /T 10 
