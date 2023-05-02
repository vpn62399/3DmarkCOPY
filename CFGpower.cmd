wmic CSPRODUCT

POWERCFG /DEVICEQUERY wake_armed
powercfg /lastwake
powercfg /SYSTEMPOWERREPORT
if 1 NEQ %errorlevel% (
	C:\Windows\system32\sleepstudy-report.html
)


pause