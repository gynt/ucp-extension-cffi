param (
    [Parameter(Mandatory=$false)][string]$BuildType = "Release",
    [Parameter(Mandatory=$false)][string]$UCP3Path = "." # We don't use it
)

$BuildTypeLC = $BuildType.ToLower()

Push-Location cffi-lua

rm -R build -ErrorAction SilentlyContinue

mkdir build

Push-Location build

Invoke-WebRequest https://www.nuget.org/api/v2/package/lua/5.4.6 -OutFile lua-5.4.6.zip
Expand-Archive lua-5.4.6.zip -DestinationPath lua

mkdir deps
mkdir deps\include

cp ".\lua\build\native\bin\Win32\v143\$BuildType\lua.dll" deps\lua.dll
cp ".\lua\build\native\lib\Win32\v143\$BuildType\lua.lib" deps\lua.lib
cp -r .\lua\build\native\include\* deps\include

python -m pip show meson
if ($LASTEXITCODE -ne 0) {
    python -m pip install meson
}

meson setup .. -Dlua_version=vendor -Dtests=false --buildtype=$BuildTypeLC --vsenv
meson compile -C . --vs-args /Zc:threadSafeInit- --vs-args /EHa
#ninja all

Pop-Location

Pop-Location
