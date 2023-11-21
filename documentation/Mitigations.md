# Mitigations




### Disable Powershell from User

Disabling Powershell usage, blocks the execution of our Digispark payloads as they all use keystroke injections to run commands in Powershell.

**Disabling Powershell from User via Group Policies:** 
Easiest way, is to open the Windows search, and type `gpedit.msc` and open.   
![](Mitigations_res/Mitigations-.png)

In Local Group Policy Editor:   
Select: User Configurations -> System -> Don't run specified Windows applications -> Double Click
![](Mitigations_res/Mitigations-%201.png)

In the settings, choose: Enabled -> "List of disallowed applications" -> Show -> Value -> powershell.exe.   
![](Mitigations_res/Mitigations-%202.png)

Then Ok -> Ok 

Outcome:   
![](Mitigations_res/Mitigations-%203.png)

Now opening the Powershell gives:   
![](Mitigations_res/Mitigations-%204.png)

### Disable Windows Run from User

This one is more effective way against our attacks, as it still allows the usage of Powershell for User. Powershell is useful tool, so most likely it's needed to do stuff, so disabling it would be not good for business.    

To disable Run via Group Policies, open the Windows search, and type `gpedit.msc` and open.   
![](Mitigations_res/Mitigations-.png)

In Local Group Policy Editor:   
Select: User Configurations -> System -> Remove Run menu from Start Menu -> Double Click   
![](Mitigations_res/Mitigations-%205.png)

In settings, select: Enabled   
![](Mitigations_res/Mitigations-%206.png)

Then: Ok -> Ok

Outcome:   
![](Mitigations_res/Mitigations-%207.png)

Now trying to use Run, gives:   
![](Mitigations_res/Mitigations-%208.png)

