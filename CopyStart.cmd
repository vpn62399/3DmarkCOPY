POWERCFG /CHANGE monitor-timeout-ac 0
POWERCFG /CHANGE disk-timeout-ac 0
POWERCFG /CHANGE standby-timeout-ac 0
POWERCFG /CHANGE hibernate-timeout-ac 0
rem %HOMEDRIVE%\Windows\System32\UserAccountControlSettings.exe

set xp="\\192.168.60.245\public2"
set xp="\\slax\public2"

robocopy %xp%\tools\ %USERPROFILE%\Desktop 7za.exe

IF %ERRORLEVEL% GTR 1 (
	set xp="\\192.168.60.245\public"
	set xp="\\slax\public"
	goto cstart

)

:cstart
rem explorer %xp%
robocopy %xp%\ %USERPROFILE%\Desktop 3DmarkCOPY.cmd
robocopy %xp%\tools %USERPROFILE%\Desktop 7za.exe
%USERPROFILE%\Desktop\3DmarkCOPY.cmd

