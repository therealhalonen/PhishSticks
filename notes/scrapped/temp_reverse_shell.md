# Reverse shell
A reverse shell is technique that involves the establishment of a network connection, allowing the attacker to gain access and control, between an attacker-controlled system and a target system.
Shell session vs Reverse Shell:
- In a typical shell session, a user connects to a remote system to execute commands.
- In a reverse shell scenario, the connection is reversed, with the compromised target system initiating the connection back to the attacker's system.

Reverse shells are favored by attackers for their stealthy nature. Since the connection is initiated from the inside, it can be challenging for security tools to detect or block these connections, making them an attractive option for malicious actors.

### Reverse shell & Cyber Kill Chain
6. Command & Control: 
	- As reverse shell acts as a communication channel for the attacker to interact with the system, it allows attacker to maintain control over the compromised system, enabling them to execute commands, exfiltrate data, or even move laterally within the system.
7. Actions on objectives
	- While more persistent foothold can be received, if system's crucial flaws are identified, the reverse shell allows to escalate privileges and therefor gives possibility to attackers to achieve their main objectives, whether it is theft, manipulations, or other malicious actions in the victim system.


### How does it work
Our implementation of reverse shell, works in a process, where USB connected device acts as a dropper for the payload and attacker's device (pc, server, smartphone etc) is listening to incoming connections. 
- USB device, when plugged in, runs a code, using keystroke injections.
	- Command includes; opening Windows Run, typing a command, that, using powershell, downloads the netcat binary from a website or server. After download is finished, it executes netcat, and with defined parameters, calls the attacker's device forming a connection that allows attacker to run commands in the compromised system remotely.

### Potential use cases
*In a legitimate context, reverse shells can be used for remote system administration, troubleshooting, and monitoring. It is often related in cybersecurity to hacking and performing malicious activities*

**Overall:**   
Reverse shell overall is a great way for initial, non OS dependent, foothold of systems, including desktops, servers, IoT devices etc.   
Also what makes it powerfull, is that there are plenty of ways to achieve it for example different code languages and possibly already existing binaries inside the victim's system.

**In our project:**   
Usage of reverse shell in our project, is getting an initial foothold of Windows 10 - Enterprise and Pro edition, desktop operating systems.   
The privilege escalation, was done experimentally, while not being included in the project scope.   

### Limitations and restrictions 
Reverse shell requires network connection.   
Network connection from victim, could also be denied or prohibited for the user, who as, the commands are run.   
In our project, using the netcat, the binary download could also be denied for the user, as a safety measure, but as we were doing everything with the default settings in the OS, there were no problems.


### Lifecycle
In our case, the command and binary, to get Reverse shell to victim device, are delivered with the help of USB device.    
USB device, needs to be physically attached to the victim, where malicious code will be ran. 
After the code is ran, the reverse shell connection from victim to attacker is established and attacker will have the session open.   
The session will not disconnect, if the USB device is unplugged, as it was only needed as so called Dropper for the initial actions to get the shell access.   
In the session, attacker is able to do everything, the currently logged user, the same user that had logged in, when the code was ran, could do.   
Also if there are any vulnerabilities in the system to exploit, the attacker can gain more privileged accesses, and do some serious damage.   
After more enumeration is done or objectives are achieved, attacker can terminate the connection.   
The connection could also be disconnected from the victim's side, if network is disconnected, or if the malicious activities are identified and terminated.

### Mitigation 
In our project and mostly overall starting from:   
[BadUSB device - Mitigation](/documentation/conops_badusb_device.md#mitigation)   

Defending against reverse shells involves:
- Using intrusion detection systems to monitor network traffic for suspicious behavior.
- Using firewalls and network segmentation to restrict unauthorized network connections.

And of course, as always: awareness, proper education and guidance of users.