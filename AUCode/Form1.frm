VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form Form1 
   Caption         =   "Auto Update"
   ClientHeight    =   1065
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2295
   LinkTopic       =   "Form1"
   ScaleHeight     =   1065
   ScaleWidth      =   2295
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Check for Update"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1695
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   1320
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
CheckForNewVersion "BillStat", Form1, "http://www.btinternet.com/~samst/", "Version.inf", "http://www.btinternet.com/~samst"
End Sub

