'
' Copyright 2011 Joyent, Inc. All rights reserved
'

Function hostname() 
	Set objNetwork = CreateObject("Wscript.Network")
	strComputer = objNetwork.ComputerName
	hostname = strComputer
End Function

Function setPassword()
	Set objShell = CreateObject("Wscript.Shell")
	Dim strPassword

	For retries = 0 To 3
		Set objExec = objShell.exec("c:\smartdc\bin\mdata-get administrator_pw")

		Do While objExec.Stdout.AtEndOfStream <> True
			strPassword = objExec.StdOut.ReadLine

			Select Case strPassword
				Case "SUCCESS", "NOTFOUND", ""
					Debug.WriteLine("ignoring line: " + strPassword)
				Case Else
					Set objUser = GetObject("WinNT://" & hostname & "/Administrator, user")
					objUser.SetPassword strPassword
					objUser.SetInfo

					Debug.WriteLine("password set.")

					Exit Function
			End Select
		Loop
	Next
End Function

setPassword
