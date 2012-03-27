'
' Copyright 2011 Joyent, Inc. All rights reserved
'

Function hostname() 
	set objNetwork = CreateObject("Wscript.Network")
	strComputer = objNetwork.ComputerName
	hostname = strComputer
End Function

Function setPassword()
	set objShell = CreateObject("Wscript.Shell")
	set objExec = objShell.exec("c:\smartdc\bin\mdata-get administrator_pw")
	Dim strPassword

	Do While objExec.Stdout.AtEndOfStream <> True
		strPassword = objExec.StdOut.ReadLine
    set objUser = GetObject("WinNT://" & hostname & "/Administrator, user")
    objUser.SetPassword strPassword
    objUser.SetInfo
	loop

end Function

setPassword
