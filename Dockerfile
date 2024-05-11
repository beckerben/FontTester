FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# TODO: COPY ANY ADDITIONAL FILES NEEDED FOR YOUR APPLICATION TO RUN

# THE FOLLOWING 3 LINES INSTALL THE CUSTOM FONT INTO THE IMAGE
COPY HelmetCondensed.ttf C:/Windows/Fonts/
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' -Name 'HelmetCondensed Normal (TrueType)' -Value 'HelmetCondensed.ttf' -PropertyType String -Force

# THE FOLLOWING LINE COPIES THE INDEX.HTM FILE TO THE IIS ROOT FOLDER TO VISUALLY DEMONSTRATE THE FONT
# THIS LINE IS NOT NEEDED FOR THE FONT INSTALLATION, IT IS JUST TO DEMONSTRATE THE FONT
COPY index.htm C:/inetpub/wwwroot/

# NOTE: NO ENTRYPOINT OR CMD IS NEEDED BECAUSE THIS BASE IMAGE HAS AN ENTRYPOINT THAT RUNS IIS
