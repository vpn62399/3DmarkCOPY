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

%HOMEDRIVE%\Windows\System32\UserAccountControlSettings.exe
PowerShell Set-Service -Name wuauserv -StartupType Disabled
PowerShell Stop-Service -Name wuauserv

echo %SE7NO% >> SE7SN.txt
echo %SE7NO% >> %SE7NO%
POWERCFG /CHANGE monitor-timeout-ac 0
POWERCFG /CHANGE disk-timeout-ac 0
POWERCFG /CHANGE standby-timeout-ac 0
POWERCFG /CHANGE hibernate-timeout-ac 0

set xp="\\192.168.1.132\public2"
set xp=\\slax\public2

robocopy %xp%\tools %USERPROFILE%\Desktop 7za.exe

IF %ERRORLEVEL% GTR 0 (
	set xp="\\192.168.1.132\public"
	set xp=\\slax\public
	goto START
)


:START
time /t
net time \\slax /set /y
%xp%\Bginfo64.exe %xp%\BGcon.bgi /NOLICPROMPT /SILENT /TIMER:0
subst x: %xp%
robocopy %xp% %USERPROFILE%\Desktop openFileServer.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop CopyStart.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop 3DmarkCOPY.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop rebootToFW.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop nvPowerPL370.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop NirCmdSavescreenshot.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop ncpacpl.cmd /is /xx 
robocopy %xp% %USERPROFILE%\Desktop CFGpower.cmd /is /xx 
robocopy %xp%\Tools %USERPROFILE%\Desktop "CrystalDiskMark7_0_0h.zip" /is /xx 
robocopy %xp%\Tools %USERPROFILE%\Desktop "GPU-Z.2.52.0.exe" /is /xx 
robocopy %xp%\Tools %USERPROFILE%\Desktop "FurMark_1.30.0.0_Setup.exe" /is /xx 
robocopy %xp%\Tools %USERPROFILE%\Desktop "FSCapture90.zip" /is /xx 
robocopy %xp%\FFmpeg %USERPROFILE%\Desktop "ffmpeg-5.1.2-essentials_build.7z" /is /xx 
robocopy %xp%\windowsdesktop-runtime-6.0.7-win-x64 %USERPROFILE%\Desktop "windowsdesktop-runtime-6.0.7-win-x64.exe" /is /xx 
%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\ %xp%\Tools\cpu-z_2.05-en.zip cpuz_x64.exe

:Chrome
msiexec /i %xp%\googlechromestandaloneenterprise64.msi /passive /qf /norestart

rem  NVIDIA VGA
curl -O http://slax/ssd/NVIDIA/531.68-desktop-win10-win11-64bit-international-dch-whql.exe
curl -O http://slax/ssd/NVIDIA/474.30-desktop-win10-win11-64bit-international-dch-whql.exe

rem AMD Radeon Drivers
curl -O http://slax/ssd/AMD/whql-amd-software-adrenalin-edition-23.4.2-win10-win11-apr20.exe


rem 3Dmark
:3Dmark
robocopy %xp%\3Dmark %USERPROFILE%\Desktop 3DMark-v2-26-8092.zip /is /xx 
rem curl -O http://slax/ssd/3Dmark/3DMark-v2-25-8043.zip

if %errorlevel% GTR 1 (
	goto 3Dmark
) else (
	rem %USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\3dmark %USERPROFILE%\Desktop\3DMark-v2-25-8043.zip
	rem start %USERPROFILE%\Desktop\3dmark\3dmark-setup.exe /silent /install
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\3dmark %USERPROFILE%\Desktop\3DMark-v2-26-8092.zip
	start %USERPROFILE%\Desktop\3dmark\3DMark-v2-26-8092\3dmark-setup.exe /silent /install
)

rem FFxbench
:FFxbench
robocopy %xp%\3Dmark %USERPROFILE%\Desktop ffxvbench_installer.zip /is /xx 
rem curl -O http://slax/ssd/3Dmark/ffxvbench_installer.zip

if %errorlevel% GTR 1 (
	goto FFxbench
) else (
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\ffxvbench %USERPROFILE%\Desktop\ffxvbench_installer.zip
	start %USERPROFILE%\Desktop\ffxvbench\ffxvbench\ffxvbench_installer.exe /SILENT
)

if AMD64 == %PROCESSOR_IDENTIFIER:~0,5% (
	rem AMD OnbordVGA
	robocopy %xp%\AMD %USERPROFILE%\Desktop amd_vga_driver.zip /is /xx 
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\AMD_VGA %USERPROFILE%\Desktop\amd_vga_driver.zip

) else (
	rem Intel VGA
	rem NEW LGA1700
	robocopy %xp%\INTEL %USERPROFILE%\Desktop DRV_VGA_Intel_RPL_TP_W11_64_V3101013959_20230111R.zip /is /xx 
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\Intel_VGA %USERPROFILE%\Desktop\DRV_VGA_Intel_RPL_TP_W11_64_V3101013959_20230111R.zip

	rem OLD LGA1151 LGA1200
	robocopy %xp%\INTEL %USERPROFILE%\Desktop DRV_VGA_Intel_ADL_TP_W11_64_V3001011218_20220208R.zip /is /xx 
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\Intel_VGA2 %USERPROFILE%\Desktop\DRV_VGA_Intel_ADL_TP_W11_64_V3001011218_20220208R.zip

	rem Intel Chipset
	robocopy %xp%\INTEL %USERPROFILE%\Desktop\intelChipset DRV_MEI_Intel_Cons_TP_W11_64_V2240340_20221208R.zip /is /xx 
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\intelChipset\mei %USERPROFILE%\Desktop\intelChipset\DRV_MEI_Intel_Cons_TP_W11_64_V2240340_20221208R.zip
	robocopy %xp%\INTEL %USERPROFILE%\Desktop\intelChipset DRV_Chipset_Intel_TP_TSD_W11_64_V101191998340_20220928R.zip /is /xx 
	%USERPROFILE%\Desktop\7za.exe x -y -o%USERPROFILE%\Desktop\intelChipset\chip %USERPROFILE%\Desktop\intelChipset\DRV_Chipset_Intel_TP_TSD_W11_64_V101191998340_20220928R.zip
)

rem pnputil 
pnputil /add-driver %USERPROFILE%\Desktop\*.inf /subdirs /install


rem JST
time /t
net time \\slax /set /y

rem BGInfo
%xp%\Bginfo64.exe %xp%\BGcon.bgi /NOLICPROMPT /SILENT /TIMER:0

timeout 5
set time2=%time: =0%
start dxdiag /dontskip /t %xp%\Dxdiag\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%.txt
start dxdiag /dontskip /x %xp%\Dxdiag\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%.xml
start cpuz_x64.exe -txt=%xp%\CPU-Z\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%

set time2=%time: =0%
start shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}
start %xp%\NirCmd\nircmd.exe cmdwait 2000 savescreenshot %xp%\NirCmd\%SE7NO%-%COMPUTERNAME%-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%.png


timeout 5
start devmgmt.msc
start %USERPROFILE%\Desktop\cpuz_x64.exe
"%ProgramFiles%\Google\Chrome\Application\chrome.exe" https://www.nict.go.jp/JST/JST5.html
rem start ncpa.cpl
rem start %HOMEDRIVE%\Windows\System32\UserAccountControlSettings.exe

pause
rem explorer %xp%


rem HELP
rem コマンドラインから「デスクトップの表示」
rem http://scripting.cocolog-nifty.com/blog/2009/07/post-54d6.html
rem start shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}
rem Windowsコマンドプロンプトの時刻取得するtimeコマンドの使い方
rem https://ossan-tech.work/time-command/
rem Windowsのバッチファイル中で日付をファイル名に使用する
rem https://atmarkit.itmedia.co.jp/ait/articles/0405/01/news002.html
rem PROCESSOR_IDENTIFIER=Intel64 Family 6 Model 30 Stepping 5, GenuineIntel
rem echo %PROCESSOR_IDENTIFIER:~0,7%    = Intel64