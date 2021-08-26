function Set-FileLine {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $FileName,

        [Parameter(Mandatory)]
        [string] $LinePart,

        [Parameter(Mandatory)]
        [string] $NewContent
    )

    $content = Get-Content $FileName
    $lineToReplace = $content | Select-String $LinePart | Select-Object -exp Line
    $content | % { $_.Replace($lineToReplace, $NewContent) } | Set-Content $FileName -Force
}

function Remove-DesktopIcon {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $ShortcutName
    )

    $desktop = [Environment]::GetFolderPath("Desktop")
    Remove-Item -Path "$desktop\$ShortcutName" -Force -ErrorAction SilentlyContinue
}

function New-DesktopIcon {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $ShortcutName,

        [Parameter(Mandatory)]
        [string] $TargetPath
    )

    $desktop = [Environment]::GetFolderPath("Desktop")
    Install-ChocolateyShortcut `
        -ShortcutFilePath "$desktop\$ShortcutName" `
        -TargetPath $TargetPath
}