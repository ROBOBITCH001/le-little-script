###########################################################
#  By error303 basic on Proliantaholic                    #
###########################################################

# Elevate Powershell to Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

# List installed language(s), add en-us language if not found
$i = -1
Write-Host Installed language`(s`):
for ($n=0; $n -lt (Get-WinUserLanguageList).Count; $n++) {
    Write-Host (Get-WinUserLanguageList)[$n].LanguageTag (Get-WinUserLanguageList)[$n].Autonym
    if ((Get-WinUserLanguageList)[$n].LanguageTag -eq "en-US") {
        $i = $n
    }
    if ((Get-WinUserLanguageList)[$n].LanguageTag -eq "en-US") {
        $i = -2
    }
}
if ($i -eq -2) {
    Write-Host "en-us language installed" -ForegroundColor White -BackgroundColor Red
    pause
    exit
}
if ($i -eq -1) {
    $OldList = Get-WinUserLanguageList
    $OldList.Add("en-US")
    Set-WinUserLanguageList -LanguageList $OldList -Force
    $i = $n
}

#Remove old IME (ChangJie and Quick)
Write-Host "Remove old IME (ChangJie and Quick)..." -ForegroundColor Black -BackgroundColor Green
$UserLanguageList = Get-WinUserLanguageList
$UserLanguageList[$i].InputMethodTips.Remove($GuidChangJie) > $null 2>&1
$UserLanguageList[$i].InputMethodTips.Remove($GuidQuick) > $null 2>&1
Set-WinUserLanguageList -LanguageList $UserLanguageList -Force


Write-Host Installed language`(s`) now:
for ($n=0; $n -lt (Get-WinUserLanguageList).Count; $n++) {
    Write-Host (Get-WinUserLanguageList)[$n].LanguageTag
}

pause