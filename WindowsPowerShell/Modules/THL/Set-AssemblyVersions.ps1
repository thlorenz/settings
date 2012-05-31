function Set-AssemblyVersions($version_number) {    
    if ($version_number) {
        $assembly_version = "[assembly: AssemblyVersion(`"$version_number`")]"
        $assemblyfile_version = "[assembly: AssemblyFileVersion(`"$version_number`")]"

        gci -recurse . -include AssemblyInfo.fs | foreach {
                $content = Get-Content -path $_

                $content = $content -replace "^ *\[assembly: AssemblyVersion.*?\]", $assembly_version 
                $content = $content -replace "^ *\[assembly: AssemblyFileVersion.*?\]", $assemblyfile_version

                $content | Set-Content $_
        }
    }
    else
    {
        "Usage: Set-AssemblyVersions versionNumber (e.g. 1.2.3.4)"
    }
}
