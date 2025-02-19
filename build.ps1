param (
  [Parameter(Mandatory=$true)][string]$BuildType,
  [Parameter(Mandatory=$true)][string]$UCP3Path
)


rm -R build -ErrorAction SilentlyContinue

mkdir build

Push-Location build

Invoke-WebRequest https://www.nuget.org/api/v2/package/lua/5.4.6 -OutFile lua-5.4.6.zip
Expand-Archive lua-5.4.6.zip -DestinationPath lua

mkdir deps
mkdir deps\include

cp .\lua\build\native\bin\Win32\v143\Release\lua.dll deps\lua.dll
cp .\lua\build\native\lib\Win32\v143\Release\lua.lib deps\lua.lib
cp -r .\lua\build\native\include\* deps\include

meson setup .. -Dlua_version=vendor -Dtests=false
ninja all

Pop-Location
