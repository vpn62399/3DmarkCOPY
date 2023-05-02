@echo off
echo ****************************************
echo *                                      *
echo *       Start from 2023H1              *
echo *          ver 1.0.5.1                 *
echo *                                      *
echo ****************************************

if EXIST SE7SN.txt (
    for /F %%s in (SE7SN.txt) do set SE7NO=%%s
) else (
    echo Please enter SE number....
    set SE7NO=SE70000000
    set /P SE7NO=
)

echo %SE7NO% >> SE7SN.txt
echo %SE7NO% >> %SE7NO%
POWERCFG /CHANGE monitor-timeout-ac 0
POWERCFG /CHANGE disk-timeout-ac 0
POWERCFG /CHANGE standby-timeout-ac 0
POWERCFG /CHANGE hibernate-timeout-ac 0
PowerShell Set-Service -Name wuauserv -StartupType Disabled
PowerShell Stop-Service -Name wuauserv

set xp=\\slax\public
time /t
net time \\slax /set /y

%xp%\Bginfo64.exe %xp%\BGcon.bgi /NOLICPROMPT /SILENT /TIMER:0

set time2=%time: =0%
start dxdiag /t %xp%\Dxdiag\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%-Manual.txt

set time2=%time: =0%
start /min %xp%\NirCmd\nircmd.exe cmdwait 2000 savescreenshot %xp%\NirCmd\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%-Manual.png



exit
    %HOMEDRIVE%\Windows\System32\UserAccountControlSettings.exe
    Get-WmiObject Win32_Processor

