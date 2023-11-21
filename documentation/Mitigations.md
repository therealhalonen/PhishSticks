# Mitigations




## Disable Powershell from User

Disabling Powershell usage, blocks the execution of our Digispark payloads as they all use keystroke injections to run commands in Powershell.

**Disabling Powershell from User via Group Policies:** 
Easiest way, is to open the Windows search, and type `gpedit.msc` and open.   
![](Mitigations_res/Mitigations-.png)

In Local Group Policy Editor:   
Select: User Configurations -> Administrative Templates -> System -> Don't run specified Windows applications -> Double Click
![](Mitigations_res/Mitigations-%201.png)

In the settings, choose: Enabled -> "List of disallowed applications" -> Show -> Value -> powershell.exe.   
![](Mitigations_res/Mitigations-%202.png)

Then Ok -> Ok 

Outcome:   
![](Mitigations_res/Mitigations-%203.png)

Now opening the Powershell gives:   
![](Mitigations_res/Mitigations-%204.png)

## Disable Windows Run from User

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



## Ransomware protection - Controlled folder access
To defend yourself against, at least our ransomware, the effective way lies inside Windows own Security settings.   

Go to: Windows Security -> Virus & threat protection -> Manage settings -> Manage Controlled folder access -> On   
![](Mitigations_res/Mitigations-%2010.png)

This prevents the running of our ransomware, giving the following notification:   
![](Mitigations_res/Mitigations-%209.png)

*During testing, there weren't any folders that this wouldn't cover.*
**Also, this didn't defend against the keylogger or reverse shell.**


### Disabling removable devices
This one is quite heavy measures...    
**So this would be effective against our attacks, but also would disable all removable devices.**   

To disable all removable devices via Group Policies, open the Windows search, and type `gpedit.msc` and open.   
![](Mitigations_res/Mitigations-.png)   

In Local Group Policy Editor:   
Select: Computer Configurations -> Administrative Templates -> System -> Device Installation -> Device Installation Restrictions -> Prevent installation of removable devices -> Double Click    
![](Mitigations_res/Mitigations-%2013.png)    
![](Mitigations_res/Mitigations-%2014.png)   

Enabled -> Ok

Outcomes when plugging our Digispark device in:    
![](Mitigations_res/Mitigations-%2011.png)   

![](Mitigations_res/Mitigations-%2012.png)   

