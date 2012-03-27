@echo off

REM After a system has been initialized, this command is ran
REM in parallel to the SetupSync and SetupAsync commands during
REM windows setup

wscript c:\smartdc\bin\set-administrator-password.vbs
