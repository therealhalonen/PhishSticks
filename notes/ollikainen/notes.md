All testing is done (unless otherwise stated) on a computer with 
  * Processor	Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz, 3696 Mhz
  * 16 GB RAM
  * GeForce GTX 1080 - series GPU
  * Running a Windows 10 Virtual Machine on VirtualBox using 8GB of RAM 

# Week 39

## Management (yes, project managers actually do some work from time to time)

Finally getting most of the project leading duties done (weeks 38 & 39), such as

  * Creating a timesheet for the project
  * Familiarizing group members on how to use worksheet (reminder: remind group members to actually update the worksheet)
  * Keeping the [main page README.md](/README.md) up to date
  * Discussing report formatting with the group (consider TODO: actual written guidelines)
  * Creating a [Youtube channel](https://www.youtube.com/@phishsticks_pentest/videos) and managing user rights so everyone can upload
  * Planning roadmap for the project (TODO: update project plan to be up to date, fix Gantt chart)

## Keylogger

**Educational purposes only!**

The first step on this weeks task was to perform reconnaissance on previous work done on the subject. [therealhalonen](https://github.com/therealhalonen/) had [a preliminary keylogger demo](/payloads/keylogger/keylogger) that was edited from the work of [https://mohamedaezzat.github.io/posts/keylogger/](https://mohamedaezzat.github.io/posts/keylogger/). It uses python as its code language and a python library [pynput](https://pypi.org/project/pynput/) for keylogging. We'll probably put this version on the backburner, since there is a more interesting potential source:

[Don't Trust That USB](https://terokarvinen.com/2021/dont-trust-that-usb/) briefly covers [Team Sharap's (in Finnish)](https://teamsharap.wordpress.com/) project, where the group built a BadUSB keyboard that utilised (edited) [keylogger code written by MTK911 (Muhammad Talha Khan)](https://github.com/MTK911/Attiny85/tree/master/payloads/KeyLogger). This seems like a good place to start, since the original code was actually written for a Digispark. Potential issues that arose with the DigiNut-project that we can improve upon:

  * Bypassing Windows Defender
  * Actually sending the file to a remote location (using target computer? LoRa?)

## Digispark

Once again [therealhalonen](https://github.com/therealhalonen/) beat me to it and did some [testing on the Digispark](https://github.com/therealhalonen/PhishSticks/blob/master/notes/halonen/notes.md#2992023) (albeit, he got his before me). Regardless, I think testing things with a simple hello world is in order. It's been a while since I worked with the Arduino IDE, and using a different board on this project (Digispark, I've worked with an Arduino & ESP32 previously). I already had Arduino IDE installed. I followed the instructions I found on [https://www.instructables.com/Digispark-Attiny-85-With-Arduino-IDE/](https://www.instructables.com/Digispark-Attiny-85-With-Arduino-IDE/). TLDR;

#### Step 1: Get a Digispark

Done

#### Step 2: Install boards

Open [Arduino IDE](https://www.arduino.cc/en/software). Go to File -> Preferences.

![arduino ide preferences](/notes/ollikainen/images/w39_3.jpg)

Add [http://digistump.com/package_digistump_index.json ](http://digistump.com/package_digistump_index.json) to the board manager URL. This is needed to manage the DigiSpark in Arduino IDE.

![url to digistump](/notes/ollikainen/images/w39_4.jpg)

Install the board manager from the Boards Manager-tab that opens up

![boards manager arduino ide](/notes/ollikainen/images/w39_5.jpg)

Output should read something like this

```Downloading packages
arduino:avr-gcc@4.8.1-arduino5
digistump:micronucleus@2.0a4
digistump:avr@1.6.7
Installing arduino:avr-gcc@4.8.1-arduino5
Configuring tool.
arduino:avr-gcc@4.8.1-arduino5 installed
Installing digistump:micronucleus@2.0a4
Configuring tool.

C:\Users\[REDACTED]\AppData\Local\Arduino15\packages\digistump\tools\micronucleus\2.0a4>"C:\Users\jipsu\AppData\Local\Arduino15\packages\digistump\tools\micronucleus\2.0a4\\install.exe"

digistump:micronucleus@2.0a4 installed
Installing platform digistump:avr@1.6.7
Configuring platform.
Platform digistump:avr@1.6.7 installed
```

Digistump should now be installed -> go to Tools -> Board: Digispark default 16.5mhz && Programmer: micronucleus

![board and programmer](/notes/ollikainen/images/w39_6.jpg)

Now we are ready to start uploading code to the Digispark! Yay!

For a quick test, Arduino IDE usually has some neat prebuilt examples. It seems that the Digistump also came with some. I tested things out with a simple keyboard example:

![keyboard example digistump](/notes/ollikainen/images/w39_7.jpg)

Selecting this opened up a second window of Arduino IDE. It had the following code written in:

```

#include "DigiKeyboard.h"

void setup() {
  // don't need to set anything up to use DigiKeyboard
}


void loop() {
  // this is generally not necessary but with some older systems it seems to
  // prevent missing the first character after a delay:
  DigiKeyboard.sendKeyStroke(0);
  
  // Type out this string letter by letter on the computer (assumes US-style
  // keyboard)
  DigiKeyboard.println("Hello Digispark!");
  
  // It's better to use DigiKeyboard.delay() over the regular Arduino delay()
  // if doing keyboard stuff because it keeps talking to the computer to make
  // sure the computer knows the keyboard is alive and connected
  DigiKeyboard.delay(5000);
}

```

So the examples actually come with really clear comments too. Neat. It also highlights a future problem we are going to tackle: **the Digispark assumes a US-style keyboard. Oh the horror.**

For now though we are sticking with the simple hello world: just click on the right-facing arrow to start uploading.

![hello kouvostoliitto](/notes/ollikainen/images/w39_8.jpg)

The output compiled for a couple of seconds, and prompted to insert the Digispark:

```

Sketch uses 2814 bytes (46%) of program storage space. Maximum is 6012 bytes.
Global variables use 110 bytes of dynamic memory.
Running Digispark Uploader...
Plug in device now... (will timeout in 60 seconds)

```

After plugging in the output continued:

```

> Please plug in the device ... 
> Press CTRL+C to terminate the program.
> Device is found!
connecting: 16% complete
connecting: 22% complete
connecting: 28% complete
connecting: 33% complete
> Device has firmware version 1.6
> Available space for user applications: 6012 bytes
> Suggested sleep time between sending pages: 8ms
> Whole page count: 94  page size: 64
> Erase function sleep duration: 752ms
parsing: 50% complete
> Erasing the memory ...
erasing: 55% complete
erasing: 60% complete
erasing: 65% complete
> Starting to upload ...
writing: 70% complete
writing: 75% complete
writing: 80% complete
> Starting the user app ...
running: 100% complete
>> Micronucleus done. Thank you!

```

After receiving the confirmation message, I switched the active window to an open notepad i had prepared. And as you can imagine, it started typing the given phrase about every 5 seconds.

![hello](/notes/ollikainen/images/w39_9.jpg)

Adding an `exit(0)`; to the end of the loop cuts off the execution after one run. Whilst uploading the updated code, I got an error:

```

writing: 80% complete
> Starting the user app ...
>> Run error -1 has occured ...
>> Please unplug the device and restart the program. 

```

I did as the IDE asked, and tried again. It failed about 3 times, and afterwards it uploaded the code succesfully. Having experience with the ESP32, this seemed like a common issue that resolves itself with persistently trying again until it works. 

---

# Week 40

This week was a busy one, so this weeks notes will probably be short for me.

## Management

Starting again with the managerial role stuff:

  * Update the main page [README.md](/README.md)
  * Update weekly notes for week 40 ([Done!](/notes/week40.md))
  * Write up the always-used description text for Youtube (done for now, remember to update video-specific descriptions) (also, make the description a bit prettier)
  * TODO: Update the project plan!! (& other related files)
  * TODO: Assess the progress made so far when compared to the timeline

## Changing USB VID / PID on Digispark

This testing is done based on the article [Change USB VID & PID on Digispark (https://blog.spacehuhn.com/digispark-vid-pid)](https://blog.spacehuhn.com/digispark-vid-pid)

### Why?

When you plug in a USB device, it sends the host machine some information on what the device is. Typically this comes in the form of a VID (Vendor ID) and PID (Product ID).

Actual use cases for making these changes to the VID/PID information might be something like
  * Digispark might be a blocked vendor on many systems
  * Spoofing the identifying information can be useful when you are trying to hide from the simulated victim/target. When looking up the connected devices on the Windows Device Manager, one might get a bit suspicious if they are greeted with a `libusb-win32 Usb Devices - Digispark Bootloader` (UPDATE: The bootloader shows up for a couple of seconds, and changes to another device after a few seconds):

![digispark on windows devmgr.msc](/notes/ollikainen/images/w40_1.jpg)

#### Locate the correct config file & BACK IT UP!

The article described, that you can find the default path via Arduino IDE. My version (Arduino IDE 2.2.1) did not have a similiar Preferences-window that was described. But nontheless, the default path remains pretty much the same:

```

C:\Users\[USER]\AppData\Local\Arduino15\packages\digistump\hardware\avr\1.6.7\libraries\DigisparkKeyboard\usbconfig.h

```

When opened up, it contains the code for the library (you can select a different library to edit amongst the files too - this will be important when combined when combining the correct library with our payloads).

![usbconfig.h](/notes/ollikainen/images/w40_2.jpg)

Before making any changes though, make sure to back up the original. This was done by copying the original file under the name of usbconfig_BACKUP.h

![usbconfig_backup](/notes/ollikainen/images/w40_3.png)

#### Make the edits

Find the part of the library containing the ID-information. Specifically:

```

#define USB_CFG_VENDOR_ID 0xc0, 0x16

```

The library is well commented, and contains directions of usage:

```

#define USB_CFG_VENDOR_ID 0xc0, 0x16
/* USB vendor ID for the device, low byte first. If you have registered your
 * own Vendor ID, define it here. Otherwise you may use one of obdev's free
 * shared VID/PID pairs. Be sure to read USB-IDs-for-free.txt for rules!
 * *** IMPORTANT NOTE ***
 * This template uses obdev's shared VID/PID pair for Vendor Class devices
 * with libusb: 0x16c0/0x5dc.  Use this VID/PID pair ONLY if you understand
 * the implications!
 */
 #define USB_CFG_DEVICE_ID 0xdb, 0x27
/* This is the ID of the product, low byte first. It is interpreted in the
 * scope of the vendor ID. If you have registered your own VID with usb.org
 * or if you have licensed a PID from somebody else, define it here. Otherwise
 * you may use one of obdev's free shared VID/PID pairs. See the file
 * USB-IDs-for-free.txt for details!
 * *** IMPORTANT NOTE ***
 * This template uses obdev's shared VID/PID pair for Vendor Class devices
 * with libusb: 0x16c0/0x5dc.  Use this VID/PID pair ONLY if you understand
 * the implications!
 */

```

I changed the byte information to match the VID/PID information of a Microsoft Internet Keyboard, found as listed on this site: [http://www.linux-usb.org/usb.ids](http://www.linux-usb.org/usb.ids)

```

#define USB_CFG_VENDOR_ID 0x6D, 0x04

#define USB_CFG_DEVICE_ID 0x08, 0xC3

```

A bit further down from these lines there are also a section for the vendor & device names:


```

#define USB_CFG_VENDOR_NAME     'd','i','g','i','s','t','u','m','p','.','c','o','m'
#define USB_CFG_VENDOR_NAME_LEN 13
/* These two values define the vendor name returned by the USB device. The name
 * must be given as a list of characters under single quotes. The characters
 * are interpreted as Unicode (UTF-16) entities.
 * If you don't want a vendor name string, undefine these macros.
 * ALWAYS define a vendor name containing your Internet domain name if you use
 * obdev's free shared VID/PID pair. See the file USB-IDs-for-free.txt for
 * details.
 */
#define USB_CFG_DEVICE_NAME     'D','i','g','i','K','e','y'
#define USB_CFG_DEVICE_NAME_LEN 7
/* Same as above for the device name. If you don't want a device name, undefine
 * the macros. See the file USB-IDs-for-free.txt before you assign a name if
 * you use a shared VID/PID.
 */
/*#define USB_CFG_SERIAL_NUMBER   'N', 'o', 'n', 'e' */
/*#define USB_CFG_SERIAL_NUMBER_LEN   0 */
/* Same as above for the serial number. If you don't want a serial number,
 * undefine the macros.
 * It may be useful to provide the serial number through other means than at
 * compile time. See the section about descriptor properties below for how
 * to fine tune control over USB descriptors such as the string descriptor
 * for the serial number.
 */

```

I changed this info too:

```

#define USB_CFG_VENDOR_NAME     'M','i','k','r','o','s','f','o','t'
#define USB_CFG_VENDOR_NAME_LEN 9

#define USB_CFG_DEVICE_NAME     'K','e','y','b','o','r','d'
#define USB_CFG_DEVICE_NAME_LEN 7

```

After making the changes I uploaded a sketch to the Digispark that does nothing, and includes the usbconfig.h library:

```

#include "DigiKeyboard.h"
#include "usbconfig.h"

void setup() {
}

void loop() {
  DigiKeyboard.sendKeyStroke(0);
  
  DigiKeyboard.print("");

}


```

 I then took out the Digispark, and plugged it back in. However, the Digispark showed up as normal in Windows Device Manager for a short while (think a couple of seconds), and then moved to the list of keyboard devices under a generic name `HID Keyboard Device`. This might be a decent outcome, considering how far the average user will go to .  I also tried to make a change to the code to make it print something (and it did, so the code worked), but the board info did not update. 

![not working :(](/notes/ollikainen/images/w40_4.png)

UPDATE: After further testing, it seems that the vendor/product ID actually changes, but Windows uses a generic driver for keyboards for the Digispark.


![it works, kinda](/notes/ollikainen/images/w40_6.png)

Also, when looking up different VID/PID combos, sites like [https://the-sz.com/products/usbid/](https://the-sz.com/products/usbid/) can be useful. When inserting ID data into the usbconfig.h file, you need to format the ID to match the documentation given. In practice:

```

0x046D 0xC308
Logitech, Inc.
Logitech USB Keyboard


```

Is to be formatted like

```
#define USB_CFG_VENDOR_ID 0x6D, 0x04 <- 0x[characters 2:4], 0x[characters 0:2]

#define USB_CFG_DEVICE_ID 0x08, 0xC3 <- 0x[characters 2:4], 0x[characters 0:2]

```

[therealhalonen](https://github.com/therealhalonen/) wrote up a script with the help of ChatGPT that [automates the process of correct formatting](/notes/halonen/update_usbconfig.py). There is also [a bash script for restoring previous IDs](/notes/halonen/restore_usbconfig).

For the average user this sort of information might be too far fetched to grasp. Additionally, changing the strings containing the vendor/device name might be for naught on Windows machines. But on Linux operating systems, this information is more readily available.

---

# Week 41

## Management

  - Updated the project plan, considered scrapping the kanban as the different tasks are moving on fluently without using it (will continue monitoring)
  - Brought the team up to speed on the progress of the project (their payloads are pretty much done), planning on how to move on with the keylogger and improving it

## Keylogging with Digispark

![digispark on a minigrip ziplock bag](images/w41_1.png)

I will be trying out uploading the keylogger code written by [Muhammad Talha Khan (MTK911)](https://github.com/MTK911/Attiny85/blob/master/payloads/KeyLogger/TimeBomb_KeyLogger.ino) licensed under GNU Lesser General Public License v3.0. The author recognizes that the payload will be stopped by most antivirus, and that is something I will have to see for myself (and later possibly tackle).

Uh oh.

![uh oh](images/w41_2.png)

Trying to insert the code given into Arduino IDE gave a warning about malicious code. Yikes! Afterwards Arduino IDE even wiped clean the code space, and doing anything further requires restarting the program.

![uh oh 2 - electric boogaloo](images/w41_3.png)

```

Operation did not complete successfully because the file contains a virus or potentially unwanted software.

```

Quick googling around the subject suggested that the problem might be due to Windows Defender or other whitelisting issues, but no workarounds were found that I was willing to try (turning off Windows Defender & firewalls etc.). I will try to bypass these problems by moving onto a Linux based system for code uploads.

---

# Week 43

This week has been mainly managing stuff, since [therealhalonen](https://github.com/therealhalonen/) and [miljonka](https://github.com/miljonka/) made such fast progress on the keylogger this week. This is where having two technical experts is starting to shine, since we already have two branches of keyloggers to work with within a week of work.

## Management

  - Cleaning up the repository and made some placeholder README:s to clarify usage and purpose of different parts of the project
  - Need to make the YouTube naming policy clearer and more alluring, ie. Ethical Hacking with Digispark - ransomware demo!
    - Also need to consider having the demos made with commentary & slowed down execution of the payloads
  - Rough planning/discussion on reporting the end results of the project:
    - Make two sets of videos for demo purposes, both displaying the installation of the device & running of the payloads
      - One set of concise (< 1min) videos detailing the concept -> use cases -> capabilities
      - One set of humoristic videos (< 5min) showcasing a possible use case (and have it include )
  - Consulting the team on which keylogger version we plan to use
  - Consulting the team on the final steps of the project
    - Testing, lots of testing
    - How to protect yourself/ your organization against attacks like this?
    - Actual written report of the project

I also need to remember to do the following tasks:
  - Comment the code at least on (near) finalized work, and ask the team to clarify points I'm not sure on
  - Mitigations for the vagrantfile need to be written up
  - Update the YouTube page & finish writing up the rest of the README:s for the Git repo

# Week 47

Testing testing...?

I made [an installation guide](windows.md) for installing a target Windows machine. Now to test the homework we gave out to Tero for his [penetration testing class](https://terokarvinen.com/2023/eettinen-hakkerointi-2023/).

I started out by making a folder called `This is a USB stick` in the Documents folder of my Windows machine. In the folder, I made a file called revsh.vbs. I pressed the `View`-button on the folder, and selected the tabs `Show hidden files` and `Show hidden files`. I then entered the code I got from [our revshell demo page](/payloads/revshell/payload/revsh.vbs) into the file, saved, and went to the properties of the file.

![](images/w47_3.png)

![](images/w47_4.png)

![](images/w47_5.png)

The file should now show up as a [VBScript script-file](https://en.wikipedia.org/wiki/VBScript) VBScript is a scripting language, and the well-documented code tells us, that the script downloads two text files, netcat, starts up netcat and opens a connection to the <ATTACKER IP>. Changing those parts of the script is integral for making the script work.

![](images/w47_6.png)

After editing the payload file, I selected the View tab again, and unticked the file extension & view hidden files -boxes. The .vbs-file disappeared! Like magic!

![](images/w47_7.png)

After reading the directions again, I realized I should've made an invisible folder, not making the actual .vbs invisible. Quick fix, make folder, move file into folder, make changes to folder properties:

![](images/w47_8.png)

Right-click -> New -> Shortcut -> pointed the shortcut to my payload:

![](images/w47_9.png)

I double clicked the shortcut, and was met with an error:

![](images/w47_10.png)

Oh yeah, I should probably have the required files to download on the attacker! I downloaded the nc64.exe from [our repo](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/revshell_demo/.payload). I also made a file called 'raport.txt' with arbitrary info inside.

```

┌──(susi㉿isopaha)-[~]
└─$ mkdir Attacker   

┌──(susi㉿isopaha)-[~]
└─$ cd Attacker   
                                                                                            
┌──(susi㉿isopaha)-[~/Attacker]
└─$ cp ~/Downloads/nc64.exe .

┌──(susi㉿isopaha)-[~/Attacker]
└─$ nano raport.txt

┌──(susi㉿isopaha)-[~/Attacker]
└─$ ls
nc64.exe  raport.txt


```

After discussing the error with [miljonka](https://github.com/miljonka/), we found out that I had ufw enabled on my Kali. Turning it off with `sudo ufw disable` fixed the problem. We tinkered around with the ports so the code changed a bit, but the theory still stands. Now double clicking the shortcut results in the .txt file opening, and netcat executing in the background with no noticeable actions happening on screen.

![](images/w47_11.png)

This is a good time to start listening in on your attacker machine. I opened up a netcat session on my Kali:

```

┌──(susi㉿isopaha)-[~]
└─$ nc -lvp 9001                  
listening on [any] 9001 ...
192.168.66.4: inverse host lookup failed: Host name lookup failure
connect to [192.168.66.2] from (UNKNOWN) [192.168.66.4] 49680
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Try the new cross-platform PowerShell https://aka.ms/pscore6

PS C:\Users\uhrilammas\Documents\This is a USB stick\payload> 


```

To ensure that I had an actual connection formed, I made a folder in the directory I was in:

![](images/w47_12.png)

Success!