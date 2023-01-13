FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN PowerShell -Command New-Item -Path "C:\\" -ItemType "directory" -Name "UiPath"; \
    Invoke-WebRequest "https://download.uipath.com/UiPathStudio.msi" -OutFile "C:\\UiPathStudio.msi"; \
    Start-Process C:\\UiPathStudio.msi -ArgumentList 'ADDLOCAL=DesktopFeature,Robot,Studio,RegisterService /quiet' -Wait; \
    $Env:Path += ';C:\\Program Files (x86)\\UiPath\\Studio';\
    Remove-Item "C:\\UiPathStudio.msi" -Force; \
    Install-PackageProvider -Name NuGet -Force; \
    Register-PSRepository -Name UiPath -SourceLocation https://www.myget.org/F/uipath-dev/api/v2; \
    Install-Module -Repository UiPath -Name UiPath.Powershell -Force; \
    Invoke-WebRequest "https://pkgs.dev.azure.com/uipath/Public.Feeds/_apis/packaging/feeds/UiPath-Official/nuget/packages/UiPath.CLI/versions/22.10.8378.25430/content" -OutFile "C:\\UiPathCLI.zip"; \
    Expand-Archive -LiteralPath "C:\\UiPathCLI.zip" -DestionationPath "C:\\UiPathCLI"; \
    $Env:Path += ';C:\\UiPathCLI\\tools'
CMD ["cmd"]
