#!/bin/python3
import sys
import re

# Define the input file as a static variable
# Add the absolute path of your usbconfig.h file here
input_file = ""

# VID, PID, VendorName, and DeviceName are provided as arguments
if len(sys.argv) != 5:
    print("Usage: python update_usbconfig.py VID PID VendorName DeviceName")
    sys.exit(1)

# Extract arguments
VID = sys.argv[1]
PID = sys.argv[2]
VendorName = sys.argv[3]
DeviceName = sys.argv[4]

# Read the contents of the input file
with open(input_file, "r") as file:
    usbconfig_content = file.read()

# Define replacement patterns
patterns = {
    "USB_CFG_VENDOR_ID": r"#define USB_CFG_VENDOR_ID\s+\w+,\s+\w+",
    "USB_CFG_DEVICE_ID": r"#define USB_CFG_DEVICE_ID\s+\w+,\s+\w+",
    "USB_CFG_VENDOR_NAME": r"#define USB_CFG_VENDOR_NAME\s+'.*'",
    "USB_CFG_VENDOR_NAME_LEN": r"#define USB_CFG_VENDOR_NAME_LEN\s+\d+",
    "USB_CFG_DEVICE_NAME": r"#define USB_CFG_DEVICE_NAME\s+'.*'",
    "USB_CFG_DEVICE_NAME_LEN": r"#define USB_CFG_DEVICE_NAME_LEN\s+\d+"
}

# Define the replacement strings
vendor_name_chars = "', '".join(VendorName)
device_name_chars = "', '".join(DeviceName)

replacements = {
    "USB_CFG_VENDOR_ID": f"#define USB_CFG_VENDOR_ID 0x{VID[2:4]}, 0x{VID[0:2]}",
    "USB_CFG_DEVICE_ID": f"#define USB_CFG_DEVICE_ID 0x{PID[2:4]}, 0x{PID[0:2]}",
    "USB_CFG_VENDOR_NAME": f"#define USB_CFG_VENDOR_NAME '{vendor_name_chars}'",
    "USB_CFG_VENDOR_NAME_LEN": f"#define USB_CFG_VENDOR_NAME_LEN {len(VendorName)}",
    "USB_CFG_DEVICE_NAME": f"#define USB_CFG_DEVICE_NAME '{device_name_chars}'",
    "USB_CFG_DEVICE_NAME_LEN": f"#define USB_CFG_DEVICE_NAME_LEN {len(DeviceName)}"
}

# Replacing the relevant lines in the file
for key, pattern in patterns.items():
    usbconfig_content = re.sub(pattern, replacements[key], usbconfig_content)

# Write the updated content back to the file
with open(input_file, "w") as file:
    file.write(usbconfig_content)

print(f"{input_file} updated successfully.")