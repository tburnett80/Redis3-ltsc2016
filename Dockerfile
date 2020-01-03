#####
## Docker file for redis cache container
#####

FROM mcr.microsoft.com/windows/servercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Add Chocolatey installer
ADD https://chocolatey.org/install.ps1 c:/temp/choco-install.ps1
ENV ChocolateyUseWindowsCompression false

# Install Chocolatey needs its own session
RUN powershell -NoProfile -ExecutionPolicy Bypass -File c:/temp/choco-install.ps1;

# Install Redis 3 
RUN choco install redis-64

EXPOSE 6379
WORKDIR /ProgramData/chocolatey/lib/redis-64

#copy the config file
COPY redis.windows.conf . 

CMD redis-server.exe redis.windows.conf
