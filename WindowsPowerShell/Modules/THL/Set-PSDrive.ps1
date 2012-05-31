function Set-PSDrive { 
    param(  [parameter(Mandatory = $true)]
    	    [ValidateNotNullOrEmpty()]
            $Name,
            $PSProvider = 'FileSystem',
            [parameter(Mandatory = $true)]
    	    [ValidateNotNullOrEmpty()]
            $Root) 
# if ((Test-Path "$Name:\")) { Remove-PSDrive $Name }
    New-PSDrive -Name $Name -PSProvider $PSProvider -Root $Root
} 


