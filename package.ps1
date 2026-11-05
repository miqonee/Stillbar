param(
    [Parameter(Mandatory=$true)][string]$BuildDirectory,
    [string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $PSScriptRoot 'artifacts' }
$source = (Resolve-Path -LiteralPath $BuildDirectory).Path
$output = [IO.Path]::GetFullPath($OutputDirectory)
$staging = Join-Path $output 'Stillbar'
if (Test-Path -LiteralPath $staging) { throw 'Package staging directory already exists.' }
New-Item -ItemType Directory -Path $staging -Force | Out-Null
foreach ($file in @('Stillbar.exe','Stillbar.Core.dll','Stillbar.BrowserHost.exe')) {
    Copy-Item -LiteralPath (Join-Path $source $file) -Destination $staging
}
Copy-Item -LiteralPath (Join-Path $source 'browser-extension') -Destination $staging -Recurse
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'LICENSE'),(Join-Path $PSScriptRoot 'README.md') -Destination $staging
$archive = Join-Path $output 'Stillbar-win-x64.zip'
if (Test-Path -LiteralPath $archive) { throw 'Package archive already exists.' }
Compress-Archive -Path (Join-Path $staging '*') -DestinationPath $archive
$hash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
[IO.File]::WriteAllText((Join-Path $output 'SHA256SUMS.txt'), "$hash  Stillbar-win-x64.zip`n", [Text.UTF8Encoding]::new($false))
Write-Output "PACKAGE=$archive"
