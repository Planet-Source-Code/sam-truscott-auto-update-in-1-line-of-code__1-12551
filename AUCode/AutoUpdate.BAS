Attribute VB_Name = "Update"
'-=-AutoUpdate Program Module-=-

'Created by Samuel Truscott

Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
    End Type
Private Declare Function ClipCursor Lib "user32" _
    (lpRect As Any) As Long

Private FilePathName As String
Private Filename As String
Private FormName As String

Private Declare Function OSGetPrivateProfileInt Lib "KERNEL32" Alias "GetPrivateProfileIntA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Long, ByVal lpFileName As String) As Long
Private Declare Function OSGetPrivateProfileSection Lib "KERNEL32" Alias "GetPrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function OSGetPrivateProfileString Lib "KERNEL32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

Private Declare Function OSWritePrivateProfileSection Lib "KERNEL32" Alias "WritePrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String, ByVal lpFileName As String) As Long
Private Declare Function OSWritePrivateProfileString Lib "KERNEL32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long

Private Declare Function OSGetProfileInt Lib "KERNEL32" Alias "GetProfileIntA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal nDefault As Long) As Long
Private Declare Function OSGetProfileSection Lib "KERNEL32" Alias "GetProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Long) As Long
Private Declare Function OSGetProfileString Lib "KERNEL32" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long) As Long

Private Declare Function OSWriteProfileSection Lib "KERNEL32" Alias "WriteProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String) As Long
Private Declare Function OSWriteProfileString Lib "KERNEL32" Alias "WriteProfileStringA" (ByVal lpszSection As String, ByVal lpszKeyName As String, ByVal lpszString As String) As Long

Private Const nBUFSIZEINI = 1024
Private Const nBUFSIZEINIALL = 4096
Private NewVersion As String
Private OldVersion As String
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Function GetInterNetFile(Location As String, Filename As String, DirToSaveAt As String, FormName As Form)
On Error Resume Next
    Dim mocha As String
    mocha = Location & Filename
    Dim bData() As Byte
    Dim intFile As Integer
    intFile = FreeFile()
    bData() = FormName.Inet1.OpenURL(mocha, icByteArray)
    Open DirToSaveAt & "\" & Filename For Binary Access Write _
    As #intFile
    Put #intFile, , bData()
    Close #intFile
    Exit Function
End Function
Private Function HyperJump(ByVal url As String) As Long
    HyperJump = ShellExecute(0&, vbNullString, url, vbNullString, vbNullString, vbNormalFocus)
End Function
Public Function HelpAbout()
MsgBox "Intergrated AutoUpdate" & vbCrLf & "by Sam Truscott, 2000" & vbCrLf & "Any Questions or Comments, send them to samst@btinternet.com" & vbCrLf & "-=-enJoy-=-", vbOKOnly, "About Intergrated AutoUpdate"
End Function
Public Function CheckForNewVersion(App_Title As String, INetForm As Form, HostSite As String, HostFile As String, UpdateFile As String) As String
Dim NewVer As String
Dim Oldver As String
Dim url As String
Dim AppDir As String
Dim YourVersion As String
Dim DOR As String
Dim FileSize As String
Dim WhatNew As String
Dim AppTitle As String
AppTitle = App_Title + ": Auto Update"
NewVer = "none"
Oldver = "none"
AppDir = App.Path
YourVersion = GetVersion
  
'Gets your Version
Oldver = YourVersion

    
    'Checks you Version
    If Oldver = "none" Then
    MsgBox "No Current Version Number"
    End
    End If

'Download 'Version.inf' file
GetInterNetFile HostSite, HostFile, AppDir, INetForm

'State & Access 'Version.inf' file
FilePathName = AppDir + "\" + HostFile
NewVer = GetPrivateProfileString("Version", "Version", "", FilePathName)
NewVersion = NewVer
DOR = GetPrivateProfileString("Version", "DOR", "", FilePathName)
FileSize = GetPrivateProfileString("Version", "Filesize", "", FilePathName)
WhatNew = GetPrivateProfileString("Version", "Whatsnew", "", FilePathName)

'Compare for newer version
If Oldver = NewVer Then
MsgBox "You have the most recent version."
'Button2Activate.Enabled = False
End
Else
If MsgBox("A new version was released on " + DOR + " and is " + FileSize + ", would you like to see the new features?", vbYesNo, AppTitle) = vbYes Then
    If MsgBox(WhatNew + "    Do you wish to download this update?", vbYesNo, AppTitle) = vbYes Then
    Download UpdateFile, App_Title
    End If
End If
'Button2Activate.Enabled = True
End If

'Delete the referance file
'Kill FilePathName
End Function



Private Function GetPrivateProfileString(ByVal szSection As String, ByVal szEntry As Variant, ByVal szDefault As String, ByVal szFileName As String) As String
   ' *** Get an entry in the inifile ***

   Dim szTmp                     As String
   Dim nRet                      As Long

   If (IsNull(szEntry)) Then
      ' *** Get names of all entries in the named Section ***
      szTmp = String$(nBUFSIZEINIALL, 0)
      nRet = OSGetPrivateProfileString(szSection, 0&, szDefault, szTmp, nBUFSIZEINIALL, szFileName)
   Else
      ' *** Get the value of the named Entry ***
      szTmp = String$(nBUFSIZEINI, 0)
      nRet = OSGetPrivateProfileString(szSection, CStr(szEntry), szDefault, szTmp, nBUFSIZEINI, szFileName)
   End If
   GetPrivateProfileString = Left$(szTmp, nRet)

End Function

Private Sub WritePrivateProfile(ByVal szSection As String, ByVal szEntry As Variant, ByVal vValue As Variant, ByVal szFileName As String)
   ' *** Write an szEntry in the inifile ***

   Dim nRet                      As Long

   If (IsNull(szEntry)) Then
      ' *** Delete the section ***
      nRet = OSWritePrivateProfileString(szSection, 0&, 0&, szFileName)
   ElseIf (IsNull(vValue)) Then
      ' *** Delete the entry in the section ***
      nRet = OSWritePrivateProfileString(szSection, CStr(szEntry), 0&, szFileName)
   Else
      ' *** Insert or replace the Entry ***
      nRet = OSWritePrivateProfileString(szSection, CStr(szEntry), CStr(vValue), szFileName)
   End If

End Sub

Private Function GetProfileString(ByVal szSection As String, ByVal szEntry As Variant, ByVal szDefault As String) As String
   ' *** Get an entry in the WIN inifile ***

   Dim szTmp                    As String
   Dim nRet                     As Long

   If (IsNull(szEntry)) Then
      ' *** Get names of all entries in the named Section ***
      szTmp = String$(nBUFSIZEINIALL, 0)
      nRet = OSGetProfileString(szSection, 0&, szDefault, szTmp, nBUFSIZEINIALL)
   Else
      ' *** Get the value of the named Entry ***
      szTmp = String$(nBUFSIZEINI, 0)
      nRet = OSGetProfileString(szSection, CStr(szEntry), szDefault, szTmp, nBUFSIZEINI)
   End If
   GetProfileString = Left$(szTmp, nRet)

End Function


Private Sub WriteProfile(ByVal szSection As String, ByVal szEntry As Variant, ByVal vValue As Variant)
   ' *** Write an szEntry in the WIN inifile ***

   Dim nRet                      As Long

   If (IsNull(szEntry)) Then
      ' *** Delete the section ***
      nRet = OSWriteProfileString(szSection, 0&, 0&)
   ElseIf (IsNull(vValue)) Then
      ' *** Delete the entry in the section ***
      nRet = OSWriteProfileString(szSection, CStr(szEntry), 0&)
   Else
      ' *** Insert or replace the Entry ***
      nRet = OSWriteProfileString(szSection, CStr(szEntry), CStr(vValue))
   End If

End Sub
Private Function Download(UpdateURL As String, AppName As String)
HyperJump UpdateURL
MsgBox "Downloading update to " + AppName + " directory.", vbOKOnly, (AppName + ":Auto Update")
End Function

Public Function GetVersion()
Dim Major As String
Dim Minor As String
Dim Revision As String
Major = App.Major
Minor = App.Minor
Revision = App.Revision
GetVersion = (Major + "." + Minor + "." + Revision)
End Function
