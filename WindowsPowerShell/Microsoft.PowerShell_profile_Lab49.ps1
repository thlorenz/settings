function cd-CSharp { cd C:\dev\Csharp }
function cd-Velocity { cd C:\dev\Lab49\CitiVelocityPoC\phase1 }
 
function ii-Chrome { ii "C:\Users\TLorenz\AppData\Local\Google\Chrome\Application\chrome.exe" }
function ii-Kaxaml { ii ${env:PROGRAMFILES(X86)}"\Kaxaml\Kaxaml.exe" }
function ii-Notepad++ { ii ${env:PROGRAMFILES(X86)}"\Notepad++\notepad++.exe" }
function ii-Reflector { ii ${env:PROGRAMFILES(X86)}"\Reflector\Reflector.exe" }
function ii-Snoop { ii ${env:PROGRAMFILES(X86)}"\Snoop\snoop.exe" }
function ii-VisualStudio2010 { ii ${env:PROGRAMDATA}"\Microsoft\Windows\Start Menu\Programs\Microsoft Visual Studio 2010\Microsoft Visual Studio 2010.lnk" }

function ep { gvim $PROFILE }
function pr { . $PROFILE }
function pt+ { Import-Module PowerTab -ArgumentList PowerTabConfig.xml }
function pt- { Remove-Module PowerTab }
function edit ($File) { notepad++ $File }
function nuget { . "$env:Home\Documents\WindowsPowerShell\NuGet_profile.ps1" }

# Make sure we always have the same home path
(get-psprovider 'FileSystem').Home = "C:\Users\tlorenz\"
$env:Home = "C:\Users\tlorenz\"


# Point PowerShell to the dropbox
$env:DropBoxPSHome = Join-Path $env:HOME "Dropboxes\Gmail\My Dropbox\Settings\WindowsPowerShell"

# Include Dropbox modules
$env:PSModulePath += ";$(Join-Path $env:DropBoxPSHome "Modules")"

$env:PATH += 	
				";$env:DropBoxPSHome" +
				";c:\Program Files\vim72" +	
				";C:\Program Files (x86)\Notepad++" +
				";C:\Windows\Microsoft.NET\Framework\v4.0.30319" +
				";C:\Program Files (x86)\FSharpPowerPack-2.0.0.0\bin" +
				";C:\Program Files (x86)\Microsoft F#\v4.0" +	
				";C:\Program Files (x86)\Microsoft FxCop 1.36" +
                ";C:\Program Files (x86)\JetBrains\dotCover\v1.0\Bin";

Import-Module prompt
Import-Module thl

