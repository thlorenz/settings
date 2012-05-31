Get-ChildItem $psScriptRoot -filter *.ps1 | foreach { . $_.FullName }
Set-SvnEditorToGvim 
Export-ModuleMember -Function * -Alias * 


