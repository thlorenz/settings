function Remove-Svn {
	svn st | %{ if ($_ -match "\!\s+(.*)") { svn rm $matches[1] } }
}

