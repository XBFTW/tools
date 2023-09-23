Run the command in Powershell:

```
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/XBFTW/tools/main/WiFiPasswordReveal.bat' -OutFile 'WiFiPasswordReveal.bat'
Start-Process -Wait -FilePath 'WiFiPasswordReveal.bat'
```
