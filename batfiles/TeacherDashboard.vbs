' Teacher Dashboard Launcher
' Opens the Teacher Dashboard in Chrome on login.
' If Chrome is already open, it opens in a new tab.

Dim WshShell, dashboardURL, chromePath
Dim possiblePaths(2), fso, i

dashboardURL = "file:///F:/ClaudeCowor/TeacherDashboard/index.html"

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

possiblePaths(0) = "C:\Program Files\Google\Chrome\Application\chrome.exe"
possiblePaths(1) = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
possiblePaths(2) = WshShell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\Google\Chrome\Application\chrome.exe"

chromePath = ""
For i = 0 To 2
    If fso.FileExists(possiblePaths(i)) Then
        chromePath = possiblePaths(i)
        Exit For
    End If
Next

If chromePath <> "" Then
    WshShell.Run """" & chromePath & """ """ & dashboardURL & """", 1, False
Else
    WshShell.Run "cmd /c start chrome """ & dashboardURL & """", 0, False
End If
