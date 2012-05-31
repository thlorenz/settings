$psd = Split-Path (Get-Variable MyInvocation).Value.MyCommand.Path

<#
    .Synopsis
        Ignores files/folders inside the given svn folder according to the given (or the default) .svnignore file.
    .Description
        $path is the path to the svn folder to apply the ignores to
        $svnIgnoreFile points to the .svnignore file to get the ignored files/folders from
        $recurse (switch) decides if the ignore will be applied to the subfolders as well.
#>
function Ignore-Svn {
    param(  [parameter(Mandatory = $true)]
    		[ValidateNotNullOrEmpty()]
            $path,
            $svnIgnoreFile = "$psd\.svnignore",
            [switch] $recurse)

             
    $fullPath = (Resolve-Path $path)
    if($recurse) { $recFlag = "-R" }
	svn propset svn:ignore $fullPath -F $svnIgnoreFile $recFlag
}
