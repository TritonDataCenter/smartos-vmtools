@echo off 

REM The sysprep batch file will run sysprep against the unattend.xml
REM file, which has all the instructions required to turn the system into
REM a "gold master" image. Note that the unattend.xml will normally contain
REM the PRODUCTKEY value, which is the product key for the version of Windows 
REM you are running.

c:\windows\system32\sysprep\sysprep /generalize /oobe /shutdown /unattend:c:\smartdc\sysprep\windows2008r2.xml
