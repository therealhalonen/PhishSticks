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
  * Keeping the [main page README.md](../README.md) up to date
  * Discussing report formatting with the group (consider TODO: actual written guidelines)
  * Creating a [Youtube channel](https://www.youtube.com/@phishsticks_pentest/videos) and managing user rights so everyone can upload
  * Planning roadmap for the project (TODO: update project plan to be up to date, fix Gantt chart)

## Keylogger

**Educational purposes only!**

The first step on this weeks task was to perform reconnaissance on previous work done on the subject. [therealhalonen](https://github.com/therealhalonen/) had [a preliminary keylogger demo](/payloads/keylogger/keylogger) that was edited from the work of [https://mohamedaezzat.github.io/posts/keylogger/](https://mohamedaezzat.github.io/posts/keylogger/). It uses python as its code language and a python library [pynput](https://pypi.org/project/pynput/) for keylogging. We'll probably put this version on the backburner, since there is a more interesting potential source:

[Don't Trust That USB](https://terokarvinen.com/2021/dont-trust-that-usb/) briefly covers [Team Sharap's (in Finnish)](https://teamsharap.wordpress.com/) project, where the group built a BadUSB keyboard that utilised (edited) [keylogger code written by Attiny85](https://github.com/MTK911/Attiny85/tree/master/payloads/KeyLogger). This seems like a good place to start, since the original code was actually written for a DigiSpark. Potential issues that arose with the DigiNut-project that we can improve upon:

  * Bypassing Windows Defender
  * Actually sending the file to a remote location (using target computer? LoRa?)

## Digispark

Once again [therealhalonen](https://github.com/therealhalonen/) beat me to it and did some [testing on the DigiSpark](https://github.com/therealhalonen/PhishSticks/blob/master/notes/halonen/notes.md#2992023) (albeit, he got his before me). Regardless, I think testing things with a simple hello world is in order. It's been a while since I worked with the Arduino IDE, and using a different board on this project (DigiSpark, I've worked with an Arduino & ESP32 previously). I already had Arduino IDE installed. I followed the instructions I found on [https://www.instructables.com/Digispark-Attiny-85-With-Arduino-IDE/](https://www.instructables.com/Digispark-Attiny-85-With-Arduino-IDE/). TLDR;

#### Step 1: Get a Digispark

Done

#### Step 2: Install boards

Open [Arduino IDE](https://www.arduino.cc/en/software). Go to File -> Preferences.

![arduino ide preferences](/notes/ollikainen/images/w39_3.jpg)

Add [http://digistump.com/package_digistump_index.json ](http://digistump.com/package_digistump_index.json) to the board manager URL. This is needed to manage the DigiSpark in Arduino IDE.

![url to digistump](/notes/ollikainen/images/w39_4.jpg)