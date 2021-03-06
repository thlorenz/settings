function Get-CommandWithParameterType
{
    <#
    .Synopsis
        Gets commands that accept a particular type of parameter
    .Description
        Searches through the loaded commands to identify commands
        that accept a parameter of a type.
    .Example
        [int] | Get-CommandWithParameterType 
    .Parameter Type
        The type or types to search for.
    #>
    param(
    [Parameter(ValueFromPipeline=$true,Position=0)]
    [Type[]]
    $Type
    )
    process{
        Get-Command -type Cmdlet, Function | Where-Object {
            $command = $_
            $commandMetaData = New-Object Management.Automation.CommandMetaData $command        
            foreach ($param in $commandMetaData.Parameters.Values) {
                foreach ($t in $type) {
                    if ($param.ParameterType -eq $t) {
                        return $true
                    } 
                }
            }
        }
    }
}
