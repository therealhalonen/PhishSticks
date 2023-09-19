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

#read encrpytion.key and read contents of the files and decrpyt the contents with the key

with open("encryption.key", "rb") as encryptionkey:
	secretkey = encryptionkey.read()

for file in files:
	with open(file, "rb") as thefile:
		contents = thefile.read()
	contents_decrypted = Fernet(secretkey).decrypt(contents)
	with open(file, "wb") as thefile:
		thefile.write(contents_decrypted)

print("Files decrypted")
