function Set-AhkVariableValue {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $FileName,

        [Parameter(Mandatory)]
        [string] $Variable,

        [Parameter(Mandatory)]
        [string] $NewValue,

        [Parameter(Mandatory=$false)]
        [switch] $Escape
    )
    if($Escape) { $escapeChar = '"' } else { $escapeChar = '' }
    $content = Get-Content $FileName
    $lineToReplace = $content | Select-String "$Variable\s:=" | Select-Object -exp Line
    $content | % { $_.Replace($lineToReplace, "$Variable := $escapeChar$NewValue$escapeChar") } | Set-Content $FileName -Force
}