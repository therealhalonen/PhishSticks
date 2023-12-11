# PhishSticks

## Project final report

### 1. Project description

#### Project goal

The goal of the project is to demonstrate a physical attack method and various forms of attacks using inconspicuous USB devices.

#### Project Objective and Results

The main goal of the project is a device or a collection of devices that showcase attack tools. Within the time constraints, the device is developed to operate without user actions. Additionally, the device(s) are initially designed to function independently, but the intention is to enhance their capabilities to operate over the network. 

The device should also be relatively inconspicuous and operate both independently in a USB port. Software components will be released (e.g., on GitHub), and documentation of development stages and results will be recorded in a Teams group created internally.

#### Presentation of Project Component Results

As part of the project, various attack methods are constructed. Concrete results arising from these methods are examined on a case-by-case basis, such as:

  * Keylogger: The device records user keystrokes and saves them to itself or the victim's machine. In the best case ("reach goal"), the data can be transferred (wirelessly) to the attacker's device. Data transfer can be developed to work over WiFi or by exploring the use of LoRa radio signal transmissions.
  * Ransomware: The device makes a visible change to the computer (e.g., encrypts files or plays music) until the user enters a password in the prompt that appears, reversing the actions of the attack.
  * Reverse shell: The device establishes a connection to the desired machine. Results can be presented, for example, by having the attacking machine perform actions on the target via the command line. In further development, focus is placed on the functionality of the reverse shell on a Windows 10 machine with default factory settings.

In addition to these, results are presented in the final presentation with a demonstration of the device's operation. Progress towards learning objectives is monitored through reports on GitHub, and reflections on results and learning are made in the final demo.

#### Learning Objectives
The learning objectives of the project include examining the physical side of penetration testing devices. Additionally, expertise in conducting network attacks on devices initially compromised by physical attacks is deepened. The goal is also to learn concrete code behind attacks that are conducted against realistic targets. As a hypothetical example being able to bypass Windows Defender is a realistic goal that this project aims to reach. This helps to understand the functioning of attacks and potentially how to defend against them.

### 2. Project results

*Present the results achieved by the project.*
*Present possible measures that will be carried out later after the end of the project, as well as possible measures related to further development.*

![](/notes/ollikainen/images/w40_5.png)

#### Project objective

Considering the project objective, we have a working prototype product that can be shipped with three different types of malware. To add to it, parts of the malware are adaptable to the needs/wants of the user. For an example, the keylogger logs user inputs, and the data can be sent via two differing routes - [HTTP POST](/payloads/keylogger/keylog_ps/) to a listening server or [email](/payloads/keylogger/keylog_python/) designated for receieving data. That way, if the target has blocked one of the two, you can just switch to the other. This device can be used to demonstrate a physical attack, and we have done so using our [YouTube video](https://www.youtube.com/watch?v=bDzVevtZiWE). The video serves as a proof of concept. And albeit a video can be edited to look like a workable product, anyone can replicate our results when the simulated attack is performed combining our written [payloads](/payloads/) with [Digispark .inos](/digispark/). Our [work notes](/notes/) show clearer details of how we combine different modular parts of the project to a working unit.

#### Component results

##### Keylogger

[The malware](/payloads/keylogger/keylog_ps/) performs as described, it records user keystrokes and saves them locally on the victim's machine. The logging of the keystrokes is done in a simple timebased loop, and can be easily configured to filter out logs that contain no data. The data is then sent via HTTP POST (or with email as described earlier). We had sending data as a reach goal, and reached it within the project time limits.

The second reach goal of sending the data wirelessly, potentially with LoRa, is a path we discarded. The project complexity would have risen critically, as we would have needed different hardware to perform that functionality. The hardware would require alterante approaches to creating and inserting the malware, as well as sending it outwards. We found that the complexity this functionality could serve as a different project altogether, and chose not to pursue it. If you're looking for a project, combining our malware with a passthrough keylogger that sends data via LoRa could be an interesting one!

#### Ransomware

Our [demo ransomware](/payloads/ransomware/) can encrypt specified file types in a specific folder. This is done to ensure, that no critical data is encrypted by accident. The default password for decryption is also given by the application.

![](https://private-user-images.githubusercontent.com/112076418/270753154-8fb9e882-b990-48cd-add6-309dd09af3be.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDE3MjY3NDYsIm5iZiI6MTcwMTcyNjQ0NiwicGF0aCI6Ii8xMTIwNzY0MTgvMjcwNzUzMTU0LThmYjllODgyLWI5OTAtNDhjZC1hZGQ2LTMwOWRkMDlhZjNiZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBSVdOSllBWDRDU1ZFSDUzQSUyRjIwMjMxMjA0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDIzMTIwNFQyMTQ3MjZaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04YjE1NjcyMTIzYzM0YWFhMDY4MTNkYmIzNGE4ZTc5YTJmNGIzMzUzMTFkNjJjZTg5Yzc2MzRlNTg0NzM4OGJiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZhY3Rvcl9pZD0wJmtleV9pZD0wJnJlcG9faWQ9MCJ9.e_NztayUD-4ffBXUc8qCBPsYVXtuihZAmC0JGHdWs0c)

#### Reverse Shell

The reverse shell works as described: it forms a connection to the attacker. The Netcat session can be used to perform actions on the target machine. Also, all of our payloads work in a Windows 10 machine with default settings.

#### Learning objectives

The learning objectives for the project were met well. The team now has a better understanding of how physical attacks can be used as a way to gain a foothold in a target system. Real methods against realistic targets were learned, as we managed to bypass Windows Defender. Additionally, we learned things that were not originally foreseen in the scope of the project. Changing the PID/VID of a device and obfuscating code are an example of such findings. Also, our video editing skills received a boost from the project.

#### Feedback from secondary and tertiary sources

Our YouTube page has 11 subscribers, 671 views and 10,5h of combined watch time and viewing time between our 8 videos as of 11.12.2023. Our Most viewed video has 160 views as of 11.12.2023. Overall this is considered a strong result, as we did not plan to make a channel originally.

We also got to present our project on Tero Karvinen's Penetration Testing course, and suggested homework related to our project. Results from the homework were varying, roughly about 30-50% (not an accurate number, based on a very rough estimate) of the students did not manage to get our payload to operate on their test environments. This is reassuring to us, since we didn't want our project to be a ready-to-go attack tool that anyone can use for any (potentially malicious) purposes.

Furthermore we presented our video in a HelSec meetup. The feedback received from the participating crowd was really positive.

### 3. Project success

Overall we consider the project a resounding success. As described in the [Project Results](#2-project-results), we reached all of our targets
*Enter a short summary of the progress of the project. Analyze the task planned for the project in relation to the actual one. Describe the achievement of project results in relation to what was planned.*

### 4. Performance of the project team

Performance of the team (read: work hours & responsibilies) is omitted from the public documentation. A copy of our worksheet is given to our instructors.

### 5. Experiences

Collectively we learned a great deal on the project. Further development our findings could include mitigating against BadUSB via PID/VID-policies, or running the tests in a more secure environment. This means tuning up Windows Defender settings, or even using other IDS/IPS applications.

Another angle tackling BadUSB attacks could be perfecting the keylogger to work as a passthrough device that sends the data on its own. Potentially even using LoRa, making the stealth aspect of the device exceptional.

### 6. Links to project materials

https://github.com/therealhalonen/PhishSticks/
https://www.youtube.com/@phishsticks_pentest/videos