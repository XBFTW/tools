@echo off
color 4C
:start

netsh wlan show profile * key=clear

goto start
