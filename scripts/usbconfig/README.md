# DigisparkKeyboard - VID, PID, DeviceName and VendorName Changer

**Designed for Linux and mostly based on personal testings**   
Two scripts.   
- One for changing the VID, PID, DeviceName and VendorName of DigisparkKeyboard, editing the `usbconfig.h`   
- One for restoring `...DigisparkKeyboard/usbconfig.h` from a backup.   
## How to use:
Download:   
- [restore_usbconfig](https://github.com/therealhalonen/PhishSticks/blob/master/scripts/usbconfig/restore_usbconfig)
- [update_usbconfig.py](https://github.com/therealhalonen/PhishSticks/blob/master/scripts/usbconfig/update_usbconfig.py)

Give proper permissions to execute.   

**restore_usbconfig:**   
Copy the `usbconfig.h` to `usbconfig.h_backup` in your Arduino IDE packages folder, somewhere most likely in:   
```
~/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries/DigisparkKeyboard/
```

Then edit the static variables in `restore_usbconfig`
```bash
original_file="ABSOLUTE PATH TO ORIGINAL usbconfig.h"
backup_file="ABSOLUTE PATH TO usbconfig.h_backup"
```

Now when executing the script, it copies the backup over the "original", in case something gets messed up.   

**update_usbconfig.py:**   
Edit the static variable for absolute path of your usbconfig.h:   
```bash
input_file = "ABSOLUTE PATH TO usbconfig.h"
```

Now you can check some PID/VID stuffs from, for example:   
https://devicehunt.com/all-usb-vendors   

And run the script with:    
```bash
./update_usbconfig.py VID PID VendorName DeviceName
```

File gets edited, and now your DigisparkKeyboard will be detected as something else, than DigiKey etc.   

---
**Scripts are commented pretty heavily to make it easily readable and understandable.**