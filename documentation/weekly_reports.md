# Week 47

### Reporting

- Mitigations document need to be finalized
- Tero gave his insight on our demo video
- Discussions on the limitations of our homework for next weeks presentation

---
# Week 46

### General

- On campus shooting video material this week
- Importance of mitigations document
- This weeks tasks include working on documentation & editing videos

---

# Week 44

### General

- Starting to approach the end of the project
- Talks of plans for the end of the project:
    - Reports on how to defend against USB attacks
    - Report on where the project is at now - it's modular and has different capabilities (ie. two versions of keylogger payloads)
    - Videos demoing usage/capabilities/concept of operation
- We agreed to present the project on another course with Tero, [Ethical Hacking 2023 by Tero Karvinen](https://terokarvinen.com/2023/eettinen-hakkerointi-2023/)
    - Create homework to accompany the presentation
### All malware:

- Consider writing the malware to RAM instead of hard drive to further increase stealth
- Write over the malware files several times, then delete
- Have the files be obfuscated on disk
- Persistence of malware is not mandatory
    - Makes forensics more difficult if the malware doesn't sit on the target until the end of times
### Keylogger

- HTTP POST vs email
    - Email is not bad choice considering the many available anonymous throwaway services available
    - Email method could be obfuscated for additional stealth
    - Email is a lot simpler and easier to cover tracks than a server for HTTP POST
    - HTTP POST could be made stealthier using a forwarder/"proxy" (not a literal proxy, but something like it)
    - Using Flask was a good idea - it's good for simple things like this
- All that being said, HTTP POST is still probably better for now
    - Email is a possible modular point for the project if the simulated attacker wants to change the exfiltration method

---

# Week 43

Week 42 was skipped due to autumn holiday. This week we recapped the work done previously, and got some pointers going forward.

### Malware

- Ransomware and reverse shell are pretty much in a demoable state
    - Further development are reach goals to improve them
- Team will now focus on the keylogger:
    - Clarify the concept
    - Clarify the actual technical operation
    - Consider implications of making a HTTP-POST vs. sending the data via e-mail ~~ - Consider other hardware if the team wants to make a hardware keylogger ~~ ~~ - Digispark probably does not have the capabilities on its own~~ ~~ - ESP32? Other boards? Stealth implications of those boards? ~~ (The team decided to focus on the Digispark due to time, complexity and budget reasons)

### Other stuff

- Write up the mitigations of the vagrantfile
- Start thinking (and reporting) of ways to protect the user (victim) against attacks
- Make the Github page (and other social media) even prettier

---
# Week 41

This weeks meeting notes with Tero:

#### PID/VID spoofing

- Find the dump files to further analyze the success/failure of spoofing
- Research USBGuard for copying the VID/PID-info of existing hardware used on the target machine
- Update notes with reflection

#### Finnish keyboard on the Digispark

- Research following subjects:
    - ASCII / UTF-8
    - Downstream/upstream of keypresses
    - Scancodes
    - Forbidden characters

#### Windows Defender

- Analyze the network traffic done by Windows Defender
- Research bypassing vs shutting down realtime protection
- Implications of tamper protection?
- LOLBAS / Windows Startup Registry / Scheduled tasks as possible attack vectors

#### General

- More reporting on reasonings, considerations and speculation when doing testing

---

# Week 40

Once again we started the week on a tuesday. 3.10.2023 to be precise, and once again we had a meeting with Tero. The topics discussed included:

- Make a unified "about"-text for the YouTube videos (still wip)
- Make a local copy of DigiStump
- Study possibilities for LoRa and ESP32 (this idea is scrapped for now due to possible scope creep)
- Add more photos to the front page! (Done, and will be under monitoring)

## TO-DO - new & old

- Work on the different payloads
- Fine-tune the reporting standards
- Make a decision on LoRa or other possibilities for moving data from the keylogger to a remote location
- Work on changing the PID/VID on the Digispark (make detecting the device harder)
- Passthrough capabilities of the Digispark?

---

# Week 39

The workweek started on 26.9.2023. We had a meeting again with Tero Karvinen. Here's a brief summary from the meeting:

## Achieved stuff

- Some preliminary scripts written - update these to have better documentation on sources used & testing

## TO-DO - new & old

- Update the README.md in the main directory of the projects GitHub to a bloggish format (done, but ongoing)
- Update the about-section of GitHub (done)
- DigiSparks still on the way - consider picking up parts from a physical store (done & done)
- Report sources & [**do the actual recon on related previous projects!!**](https://github.com/therealhalonen/PhishSticks/blob/master/notes/source_material.md)
- Make a public Youtube-page for the project to have a consisent location for video documentation (DONE: see [our Youtube channel!](https://www.youtube.com/channel/UC0iDE-K8gs-9BZl0OmsLdUQ))
    - Remember to update new links to GitHub
    - Videos should have a description that works as a standalone
- Access to worksheets for Tero

## Researchable materials

- Research lolbins/lolbas - living off the lands
- Forward progress on ransomware
    - Research pyside for a GUI
- Keylogger:
    - Passthrough possible with DigiSpark? Other hardware?
- Reverse Shell:
    - Research socket connections

---

# Week 38 (First week of reports)

We started the week on 19.9.2023 with a meeting with [Tero Karvinen](https://terokarvinen.com), the teacher responsible for guiding us through this project. There was a lot to unpack considering actual workloads. There is a lot of moving parts in the project, so it's good to get a sense of tangible goals for the project. Some things discussed in the meeting (not in order):

## Project management

- Initialize GitHub and get everyone in the project on it (done, you are reading this on GitHub)
- Start reporting work on GitHub (done-ish, everyone is getting their workflow up and running)
- Update the timetable for the project (Gantt chart)
- Update the project plan
- Finalize worksheet & kanban-board for easier time management
- Project group emphasized flexible work hours, Tero asked for a more concise schedule

## Get the list of required hardware finalized

- DigiSparks are on the way, expecting to get them this week
- Discuss additional components and ordering them
    - Actual casings for the device(s)?
    - Female USB port for passthrough? We still need to research passthrough capabilities on the DigiSpark

## Payloads

### Keylogger

- Research passthrough capabilities of the DigiSpark
- Research actual method of how keyloggers work
- Research possibilities of LoRa for sending data

### Ransomware

- Write up a ethics & security warning to consider the actual implications of the possible harm done by the payload
- Consider using very specific files as targets for encryption (use a complex file extension: i.e. *.testransomwarepayload)

### Reverse shell

- Antti demonstrated the barebones version we created on earlier weeks during planning for the project
- Create a video demonstrating that version to showcase it on the fly (done: see [therealhalonen's notes](https://github.com/therealhalonen/PhishSticks/blob/master/notes/halonen/notes.md) and [video!](https://www.youtube.com/watch?v=8v6djrHg2qI))
- Research possibilities

## Other stuff

- Make a list of earlier work done on the subject to use as source material
- Consider changing the name of the project (at least on GitHub) for SEO reasons