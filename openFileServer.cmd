set xp="\\192.168.60.245\public2"
set xp="\\slax\public2"

robocopy %xp%\tools %USERPROFILE%\Desktop 7za.exe
IF %ERRORLEVEL% GTR 0 (
	set xp="\\192.168.60.245\public"
	set xp="\\slax\public"
	goto START
)
:START
robocopy %xp% %USERPROFILE%\Desktop ChromeSetup.exe
robocopy %xp% %USERPROFILE%\Desktop CopyStart.cmd
robocopy %xp% %USERPROFILE%\Desktop 3DmarkCOPY.cmd
robocopy %xp% %USERPROFILE%\Desktop rebootToFW.cmd
robocopy %xp% %USERPROFILE%\Desktop nvPowerPL370.cmd
robocopy %xp% %USERPROFILE%\Desktop ncpacpl.cmd
robocopy %xp% %USERPROFILE%\Desktop power.cmd
explorer %xp%

rem DISM を実行するには、管理者特権のアクセス許可が必要です。
rem DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V