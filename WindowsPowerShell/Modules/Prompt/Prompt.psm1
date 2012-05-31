Get-ChildItem $psScriptRoot -filter *.ps1 | foreach { . $_.FullName }

if(Get-Module prompt) { Remove-Module prompt }

$prompt_kind = if($args[0]) { $args[0] } else { "bash" }

if($prompt_kind -eq "bash") { 

    function prompt {
      
      writeUserLocation    

      Write-Host("`n$") -nonewline -foregroundcolor Green    
      return " "
    }
}
elseif($prompt_kind -eq "svn") {

    function prompt {
        writeUserLocation    

        if(Test-Path .svn) {
          writeSvnInfo
        } 

        Write-Host("`n$") -nonewline -foregroundcolor Green    
        return " "
    }
}
elseif($prompt_kind -eq "git") {

    function prompt {
        writeUserLocation    

        if (isCurrentDirectoryGitRepository) {
          writeGitInfo
        }

        Write-Host("`n$") -nonewline -foregroundcolor Green    
        return " "
    }
}
else { Write-Host "Unknown prompt kind: $prompt_kind" }

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

