#This script attaches Azure File Storage as a network share and makes Default Website backup to the current date folder
$DailyBackupDirName = Get-Date -Format "yyy-MM-dd"
$CheckShare = Test-Path -Path z:
if (!$CheckShare) {net use z: \\5iwesipfldzx2.file.core.windows.net\share /u:5iwesipfldzx2 UOcF7hFz7npf3vsBA5weq9YMCBRl9Z44AeT5CxJ/rm4ebyedLHlSufkEdJ8/IucObnbvkVC5yo0NbZpiX7TLTg==}
$CheckDir = Test-Path -Path "Z:\VM0\$DailyBackupDirName"
if (!$CheckDir) {New-Item -ItemType Directory -Force -Path "Z:\VM0\$DailyBackupDirName"}
Copy-Item -Path "C:\inetpub\wwwroot\" -Destination "Z:\VM0\$DailyBackupDirName" -Recurse -Force
