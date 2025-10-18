@echo off
REM Backup install folder
if exist install.bak rmdir /s /q install.bak
mkdir install.bak
xcopy /s /e /y install\*.* install.bak\

REM Clean install folder
del /q install\*.*
rmdir /s /q install\img

REM Copy new installation files
copy install.new\*.* install\

echo Installation files updated. Original files backed up to install.bak