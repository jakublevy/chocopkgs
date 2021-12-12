function Update-SpicetifyConfig {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $FileName,

        [Parameter(Mandatory)]
        [string] $LinePart,

        [Parameter(Mandatory)]
        [string] $ReplacePart,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $ReplaceBy
    )

    $content = Get-Content $FileName
    $lineToReplace = $content | Select-String $LinePart | Select-Object -exp Line
    if(-not $lineToReplace.Contains('|') -And $lineToReplace.Contains($ReplacePart)) {
        $updatedLine = ''
    }
    else {
        $updatedLine =  $lineToReplace.Replace("|$ReplacePart", $ReplaceBy)
    }
    $content | % { $_.Replace($lineToReplace, $updatedLine) } | Set-Content $FileName -Force
}