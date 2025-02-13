@echo off
title NetScope [Created by Lee Junyi]
echo Loading, please wait...
:loop
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| find "SSID" ^| findstr /v "B"') do set SSID=%%i
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| find "State" ^| findstr /v "B"') do set State=%%i
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| find "Transmit rate" ^| findstr /v "B"') do set Transmit=%%i
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| find "Receive rate (Mbps)" ^| findstr /v "B"') do set Receive=%%i
ping /n 6 128.116.97.3>%temp%\results.txt
for /f "tokens=4 delims==" %%i in ('type %temp%\results.txt ^| find "Average"') do set ping=%%i
for /f "tokens=10 delims= " %%i in ('type %temp%\results.txt ^| find "Lost"') do set p_loss=%%i
for /f "tokens=2 delims= " %%i in ('netstat /e ^| find "Bytes"') do set r_bytes=%%i
for /f "tokens=2 delims= " %%i in ('netstat /e ^| find "Bytes"') do set s_bytes=%%i
cls
echo //== Network Information ==\\
echo SSID:%SSID%
echo Status:%State% 
echo Output:%Transmit% 
echo Input:%Receive%
echo.
echo //== Network Speed ==\\
echo Received Bytes:%r_bytes%
echo Sent Bytes: %s_bytes%
echo Latency: %ping%
echo Packet Loss: %p_loss%
goto loop
