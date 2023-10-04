### 19.9.2023:
 - Introduction to simple encrpytion and decryption scripts made with python 
 - Made [Simple scripts](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware/Contents) with the help of NetworkChuck's video: https://www.youtube.com/watch?v=UtMMjXOlRQc

### 26.9.2023:

My goal for today is to combine the scripts made from previous week and put them together in a form of application. For now the GUI only needs one button and maybe few text boxes. 

After researching different options I chose to go with tkinter since there was an easy to follow guide in [GeeksForGeeks](https://www.geeksforgeeks.org/create-first-gui-application-using-python-tkinter/) on how to create a GUI application. GeeksForGeeks also had a [tkinter-cheat-sheet](https://www.geeksforgeeks.org/tkinter-cheat-sheet/) which was nice.

At first I combined and tidied up the scripts a little and made functions to the code so that the application calls for the function when its started or when a button is pressed. 

My vision was that the decrypt button only decrypts if correct password is given. 

I started making the application by adding the Decrypt button, password field and a greetings message. After few hours of learning and tweaking, the code of the app looks such:

```
#main window
root = tk.Tk()
root.title("RANSOMWARE DECRYPTOR")
root.geometry("600x500")
bg_color = root.cget("bg")

#message label
message_label = tk.Label(root, text="Unfortunately you've been hit by a ransomware :( this is only a demonstration so you don't have to pay anything to anybody. Password is lihapulla", wraplength=350, width=60, font=("Arial", 13))
message_label.pack(pady=30)

#password label
pw_label = tk.Label(root, text="Enter secret password to decrypt files", font=("Arial", 13))
pw_label.pack(pady=2)

#password text field
pw_entry = tk.Entry(root, width=15, font=("Arial", 17), show="*")
pw_entry.pack(pady=2)

#button to decrypt
decrypt_button = tk.Button(root, text="Decrypt Files", font=("Arial", 13))
decrypt_button.pack(pady=5)

root.mainloop()

```

 ![2023-09-26_20-48](https://github.com/therealhalonen/PhishSticks/assets/112076418/a4f2cae1-c12d-4948-833d-ab4819715eb3)

 To be continued..

Fast forward two hours later I continued to work and managed glue everything together with the help of ChatGPT. Assinging encrypt_files function to application startup and decrypt button with decrypt_files function was done and everything was working. I added some colors and information like what files have been encrypted, is the password correct and are there any files to decrypt.

For now the app looks like this:

![2023-09-26_21-03](https://github.com/therealhalonen/PhishSticks/assets/112076418/8fb9e882-b990-48cd-add6-309dd09af3be)

Full Python code and tests can be found [here](https://github.com/therealhalonen/PhishSticks/tree/master/payloads/ransomware/ransom_app)

TO DO:
- convert working application to executable with [PyInstaller](https://datatofish.com/executable-pyinstaller/)?

### 4.10.2023:

Goal for today is to convert the working encrypt.py to encrypt.exe so it is possible to run anywhere without the need of python. I started off by reading [Finxters Python to EXE Linux: A Concise Guide to Conversion](https://blog.finxter.com/python-to-exe-linux-a-concise-guide-to-conversion/). 

"Keep in mind that while PyInstaller does an excellent job of generating executables on Linux systems, cross-compiling for Windows executables from a Linux environment is a more complex task."

After reading this I decided to go with the instruction on Windows environment since thats the environment this program is supposed to work in. So I hopped on to a Windows machine and downloaded the script and test files. I installed auto-to-py-exe that works with GUI. 
```
pip install auto-py-to-exe
auto-py-to-exe
```

![2023-10-04_17-57](https://github.com/therealhalonen/PhishSticks/assets/112076418/274f25fd-7630-4495-94ce-979c1137272c)


After giving the filepath and pressing the convert button, I ended up having Windows security stop the process, because it detected the file to be malicious, so I had to turn Real-time protection off for the time. After that I ended up having working encrypt.exe! Next thing I did was adding a custom icon to the file just for fun. 

![2023-10-04_19-25](https://github.com/therealhalonen/PhishSticks/assets/112076418/4c00b5d4-8ea5-46b8-9bbc-124bf8837e8f)


