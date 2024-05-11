# FontTester

This is a simple web server that serves a page with a custom font. It is used to test that a font is installed correctly in a Docker container.  The installed font should be available to the web server and any other custom applications added to the container that need to use it.  You can use this project as a starting point to test the installation of custom fonts in a Docker container.

## Getting Started

To build the image and then subsequently verify the installation of the custom font and view it in action, run the following commands in the root directory of this project sequentially in a powershell terminal:

```powershell
# build the image
docker build -t fonttester:latest .

# run a container from the image
docker run -d --rm --name fonttester -p 8082:80 fonttester:latest

# verify the font was installed properly in the container
docker exec -it fonttester powershell -Command "Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'"

# open the web page in a browser to view the font in action
Start-Process http://localhost:8082

# stop the container
docker stop fonttester
```

## Other Notes

The base image used for this project is `mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019`.  This image is a Windows Server Core image with the .NET Framework 4.8 & IIS installed.  The image is used to host the web server that serves the custom font. The image is rather large at just under 8GB, make sure you have sufficient disk space and remove the image after you are done with it.

The name of the key that is added to the registry for the font must be correct or the font will not install properly.  The font is installed in the container globally by copying the font file to the `C:\Windows\Fonts` directory and then adding a key to the registry under `HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts`.  The name of the key must match the name used by the font file exactly.  

You can install the font on the host machine and then check the registry to see the correct name to use for the key.  If you right click on the font file and select `Install`, the font will be installed on the host machine only for the current user, you must choose `Install for all users` to install globally and then inspect correct key to be added to the registry.
