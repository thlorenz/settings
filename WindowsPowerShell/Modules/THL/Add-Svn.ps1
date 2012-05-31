function Add-Svn {
	svn st | %{ if ($_ -match "\?\s+(.*)") { svn add $matches[1] } }
}

