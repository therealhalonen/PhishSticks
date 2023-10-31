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