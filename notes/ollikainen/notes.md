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

[Don't Trust That USB](https://terokarvinen.com/2021/dont-trust-that-usb/) briefly covers [Team Sharap's (in Finnish)](https://teamsharap.wordpress.com/) project, where the group built a BadUSB keyboard that utilised (edited) [keylogger code written by Attiny85](https://github.com/MTK911/Attiny85/tree/master/payloads/KeyLogger). This seems like a good place to start, since the original code was actually written for a Digispark. Potential issues that arose with the DigiNut-project that we can improve upon:

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

```#include "DigiKeyboard.h"

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

So the examples actually come with really clear comments too. Neat. It also highlights a future problem we are going to tackle: **the Digispark assumes a US-style keyboard. Oh the horror.** For now though we are sticking with the simple hello world: just click on the right-facing arrow to start uploading.

![hello kouvostoliitto](/notes/ollikainen/images/w39_8.jpg)

The output compiled for a couple of seconds, and prompted to insert the Digispark:

```Sketch uses 2814 bytes (46%) of program storage space. Maximum is 6012 bytes.
Global variables use 110 bytes of dynamic memory.
Running Digispark Uploader...
Plug in device now... (will timeout in 60 seconds)```

After plugging in the output continued:

```> Please plug in the device ... 
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
>> Micronucleus done. Thank you!```

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