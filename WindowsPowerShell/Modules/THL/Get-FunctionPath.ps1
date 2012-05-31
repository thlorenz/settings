function Get-FunctionPath ($functionName) { 
    dir function:$functionName | % {$_.ScriptBlock.File} 
}
