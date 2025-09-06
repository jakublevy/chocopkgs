import-module chocolatey-au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
        ".\spin.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/nimble-code/Spin/tree/master/Bin'
    $relative_urls  = $download_page.links | Where-Object href -match 'windows64\.exe' | Select-Object -expand href
    $versions = $relative_urls | % { [regex]::Match($_, 'spin(\d+)_windows64\.exe').Groups[1].Value }
    $versionNoDots = $versions | Measure-Object -Maximum | Select-Object -Expand Maximum
    $relative_url64 = $relative_urls | ? { $_ -match $versionNoDots }
    $fileName64 = $relative_url64.Split('/') | Select-Object -Last 1
    $fileName32 = $fileName64.Replace('windows64', 'windows32')
    $majorVerNum = $versionNoDots.ToString()[0]
    $versionsPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/nimble-code/Spin/tags'
    $possibleVersionsRelatives = $versionsPage.links | Where-Object href -match 'version-\d+\.\d+(\.\d+)*$' | Select-Object -expand href
    $possibleVersions = $possibleVersionsRelatives | % { [regex]::Match($_, 'version-(\d+\.\d+(\.\d+)*)$').Groups[1].Value }
    $version = Find-Version -OriginalVersion $versionNoDots -FoundVersions $possibleVersions

    @{
        Version      = $version
        #Url32        = "https://raw.githubusercontent.com/nimble-code/Spin/master/Bin/$fileName32"
        Url64        = "https://raw.githubusercontent.com/nimble-code/Spin/master/Bin/$fileName64"
        #Url64        = "http://spinroot.com/spin/Src/pc_spin$versionNoDots.zip"
        ReleaseNotes = "https://spinroot.com/spin/Doc/V$majorVerNum.Updates"
    }
}

function Find-Version {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $OriginalVersion,

        [Parameter(Mandatory)]
        [array] $FoundVersions
    )   
    foreach($foundVersion in $FoundVersions) {
        $version = $foundVersion.Replace('.', '')
        if($version -eq $OriginalVersion) {
            return $foundVersion
        }
    }
    throw "No matching version found."
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
