Run the command in Powershell:

```
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/XBFTW/tools/main/WIFI-Pass-Reveal/WifiPasswordReveal.bat' -OutFile 'WiFiPasswordReveal.bat'
Start-Process -Wait -FilePath 'WiFiPasswordReveal.bat'
```
or just run
```
netsh wlan show profile *
```
