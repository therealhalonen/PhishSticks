EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!

Version 1.0

Simple application made with python and tkinter to demonstrate how an application can encrypt and decrypt your files with extensions {'.txt', '.jpg', '.jpeg', '.png'} in given directory. Right now the application decrypts all {'.txt', '.jpg', '.jpeg', '.png'} files when user gives up the right password (lihapulla). 

Run the script or .exe file inside a safe folder with no important files (incase something goes wrong) to launch the program and enjoy

```
$ ./encrypt.py
```

How it works: https://www.youtube.com/watch?v=glqK_-qdDkw

Executable version works the same without needing different python libraries.

### To setup Digispark payload:
- [Setup Digispark](https://github.com/therealhalonen/PhishSticks/blob/master/notes/ollikainen/notes.md#digispark)
- Add correct Digikeyboard library to match your systems keyboard layout for example [DigiKeyboardFi.h](https://github.com/therealhalonen/DigiKeyboardFi/blob/master/DigiKeyboardFi.h) for Finnish keyboards (made by [therealhalonen](https://github.com/therealhalonen))
- Path of the file for Windows: C:/Users/username/Documents/Arduino/libraries/DigisparkKeyboard/DigiKeyboardFi.h
- Path of the file for Linux: ~/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries/DigisparkKeyboard/DigiKeyboardFi.h
- compile and upload [digispark_ransomware.ino](https://github.com/therealhalonen/PhishSticks/blob/master/digispark/digispark_ransomware/digispark_ransomware.ino) to your digispark
- Plug the Digispark in a computers USB slot and enjoy
  
![2023-10-31_12-24](https://github.com/therealhalonen/PhishSticks/assets/112076418/490686db-b5c4-4c00-9f7f-bc3006bd742b)

Watch the video to see it in action: https://www.youtube.com/watch?v=Bi2QOMSHeKI
