function Add-CurrentToClassPath {
    $pathInfo = get-Location
    $env:CLASSPATH += ";" + $pathInfo.Path
}
