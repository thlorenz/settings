function cd-CSharp { cd C:\dev\Csharp }
function cd-Antlr { cd c:\dev\DSL\Antlr }
function cd-Velocity { cd C:\dev\Csharp\Lab49\velocity\trunk }
function cd-Rails { cd C:\dev\Ruby\rails\agile.web.development.with.rails\depot }
function cd-FsharpSpec { cd C:\dev\FSharp\FSharpSpec\src }
function cd-PokerTell { cd C:\dev\CSharp\PokerTell }
 
function ii-Chrome { ii "C:\Users\TLorenz\AppData\Local\Google\Chrome\Application\chrome.exe" }
function ii-FoxitReader { ii "C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe" }
function ii-Kaxaml { ii ${env:PROGRAMFILES(X86)}"\Kaxaml\Kaxaml.exe" }
function ii-Miro { ii ${env:PROGRAMFILES(X86)}"\Participatory Culture Foundation\Miro\Miro.exe" }
function ii-MediaPlayer { ii ${env:PROGRAMFILES(X86)}"\Windows Media Player\wmplayer.exe" }
function ii-Notepad++ { ii ${env:PROGRAMFILES(X86)}"\Notepad++\notepad++.exe" }
function ii-Outlook { ii ${env:PROGRAMFILES(X86)}"\Microsoft Office\Office12\outlook.exe" }
function ii-Reflector { ii ${env:PROGRAMFILES(X86)}"\Reflector\Reflector.exe" }
function ii-ResophNotes { ii ${env:PROGRAMFILES(X86)}"\ResophNotes\ResophNotes.exe" }
function ii-Snoop { ii ${env:PROGRAMFILES(X86)}"\Snoop\snoop.exe" }
function ii-VisualStudio2010 { ii ${env:PROGRAMDATA}"\Microsoft\Windows\Start Menu\Programs\Microsoft Visual Studio 2010\Microsoft Visual Studio 2010.lnk" }

function ii-Velocity { ii "C:\dev\Csharp\Lab49\velocity\trunk\Velocity.Refresh.Shell\bin\Debug\Velocity.Refresh.Shell.exe" }
function ii-Docking { ii "C:\dev\Csharp\Lab49\velocity\spikes\DockingPricingPanels\DockingPricingPanels\bin\Debug\DockingPricingPanels.exe" }
function ep { gvim $PROFILE }
function pr { . $PROFILE }
function pt+ { Import-Module PowerTab -ArgumentList ${env:DropBoxPSHome}"/PowerTabConfig.xml" }
function pt- { Remove-Module PowerTab }
function edit ($File) { notepad++ $File }

$env:PATH += 	";C:\Program Files (x86)\Vim\vim73" +
				";C:\Program Files (x86)\Notepad++" +
				";C:\dev\Tools\NUnit\bin\net-2.0" +
				";C:\dev\Tools\Database\SQLite" +
				";C:\Windows\Microsoft.NET\Framework\v4.0.30319" +
				";C:\Program Files (x86)\FSharpPowerPack-2.0.0.0\bin" +
				";C:\Program Files (x86)\Microsoft F#\v4.0" +
				";C:\dev\Tools\eclipse";

# Make sure we always have the same home path
(get-psprovider 'FileSystem').Home = "C:\Users\TLorenz\"

# Point PowerShell to the dropbox
$env:DropBoxPSHome =  $env:HOME + "\Dropboxes\Gmail\My Dropbox\Settings\WindowsPowerShell"

# See http://gist.github.com/180853 for gitutils.ps1.
. (Resolve-Path ${env:DropBoxPSHome}\gitutils.ps1)

# Source all custom scripts                
. gci ~/Documents/WindowsPowershell/Scripts | % { . $_.FullName }
 
function prompt {
  
  writeUserLocation    

  if (isCurrentDirectoryGitRepository) {
    writeGitInfo
  }
  elseif(Test-Path .svn) {
    writeSvnInfo
  } 

	Write-Host("`n$") -nonewline -foregroundcolor Green    
	return " "
}

function writeUserLocation {
  Write-Host($pwd) -nonewline -foregroundcolor Green 
}

function writeShortenedUserLocation {
	$path = ""
	$pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)
	if($pathbits.length -eq 1) {
		$path = $pathbits[0] + "\"
	} else {
		$path = $pathbits[$pathbits.length - 1]
	}

	$userLocation = $env:username + '@' + [System.Environment]::MachineName + ' ../' + $path
	$host.UI.RawUi.WindowTitle = $userLocation
  Write-Host($userLocation) -nonewline -foregroundcolor Green 
}

function writeGitInfo {
  $status = gitStatus
  $currentBranch = $status["branch"]
  
  Write-Host(' [') -nonewline -foregroundcolor Yellow
  if ($status["ahead"] -eq $FALSE) {
      # We are not ahead of origin
      Write-Host($currentBranch) -nonewline -foregroundcolor Cyan
  } else {
      # We are ahead of origin
      Write-Host($currentBranch) -nonewline -foregroundcolor Red
  }
  Write-Host(' +' + $status["added"]) -nonewline -foregroundcolor Yellow
  Write-Host(' ~' + $status["modified"]) -nonewline -foregroundcolor Yellow
  Write-Host(' -' + $status["deleted"]) -nonewline -foregroundcolor Yellow
  
  if ($status["untracked"] -ne $FALSE) {
      Write-Host(' !') -nonewline -foregroundcolor Yellow
  }
  
  Write-Host(']') -nonewline -foregroundcolor Yellow 
}

function writeSvnInfo {
  $untracked=$deleted=$added=$modified=0

   switch -regex (svn st) {
       "^\?" {$untracked+=1}
       "^D"  {$deleted+=1}
       "^A"  {$added+=1}
       "^M"  {$modified+=1}         
      }
      
  $prompt_string = " [svn +$added ~$modified -$deleted"

  if ($untracked -eq 0) { 
    $prompt_string += "]"
  }
  else { 
    $prompt_string += " !]" 
  }

  Write-Host ($prompt_string) -nonewline -foregroundcolor yellow
}

function Ignore-Svn {
	svn propset svn:ignore . -F c:\dev\Misc\.svnignore -R
}

function Add-Svn {
	svn st | %{ if ($_ -match "\?\s+(.*)") { svn add $matches[1] } }
}

function Play-Mp3 ($Folder)  {
	$Mp3s = Get-ChildItem $Folder -Recurse | where{$_.Extension -match "mp3"}  
	foreach ($Mp3 in $Mp3s) {
		mp3sPlayer.exe $Mp3.FullName
		Start-Sleep -m 200
	}
}

function Del-AllEmptySubFolders($folder) {
	$items = Get-ChildItem $folder -Recurse
	foreach($item in $items)
	{
		  if( $item.PSIsContainer )
		  {
				$subitems = Get-ChildItem -Recurse -Path $item.FullName
				if($subitems -eq $null)
				{
					  "Remove item: " + $item.FullName
					  Remove-Item $item.FullName
				}
				$subitems = $null
		  }
	}
}
