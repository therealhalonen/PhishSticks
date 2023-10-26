# Week 43

Week 42 was skipped due to autumn holiday. This week we recapped the work done previously, and got some pointers going forward.

### Malware

  - Ransomware and reverse shell are pretty much in a demoable state
    - Further development are reach goals to improve them
  - Team will now focus on the keylogger:
    - Clarify the concept
    - Clarify the actual technical operation
    - Consider implications of making a HTTP-POST vs. sending the data via e-mail
~~  - Consider other hardware if the team wants to make a hardware keylogger
    - Digispark probably does not have the capabilities on its own
    - ESP32? Other boards? Stealth implications of those boards? ~~ (The team decided to focus on the Digispark due to time, complexity and budget reasons)

### Other stuff

  - Write up the mitigations of the vagrantfile
  - Start thinking (and reporting) of ways to protect the user (victim) against attacks
  - Make the Github page (and other social media) even prettier