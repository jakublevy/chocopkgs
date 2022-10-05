import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
    }
}

function get-changelog($version) {
    $changelog_url = "https://raw.githubusercontent.com/file/file/FILE$($version -replace '\.','_')/ChangeLog"

    $full_changelog = iwr $changelog_url | %{ $_.content -split "`n" } | ?{ $_ -match '^\s+\*' } | %{ $_ -replace '^\s+','' } | Select-Object -skip 1

    foreach ($entry in $full_changelog) {
        if ($entry -match '\* release ') {
            break;
        }
        $entry
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'rkitover' -repository 'file-windows').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/file_[\d.]+-x86_64\.7z' } | Select-Object -First 1
    $relative32 = $relative_url.Replace('x86_64', 'x86_32')
    $version = ([regex]::Match($relative_url, '/v(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com$relative32"
        Url64        = "https://github.com$relative_url"
        ReleaseNotes = (get-changelog $version)
    }
}

function global:au_BeforeUpdate {
    if($IsWindows) {
        set-alias 7z $env:chocolateyInstall/tools/7z.exe
    }
    else {
        set-alias 7z $(which 7z)
    }

    New-Item $psscriptroot/tools -ea ignore -ItemType Directory | out-null

    pushd $psscriptroot/tools

    Remove-Item -recurse -force * -ea ignore

    New-Item x64,x86 -ea ignore -ItemType Directory | out-null

    iwr $Latest.Url64 -outfile file-x86_64.7z
    iwr $Latest.Url32 -outfile file-x86_32.7z

    7z x file-x86_64.7z | out-null
    Move-Item file.exe x64

    7z x file-x86_32.7z | out-null
    Move-Item file.exe x86

    Remove-Item *.7z

    $Latest.Checksum64 = get-filehash x64/file.exe | % hash
    $Latest.Checksum32 = get-filehash x86/file.exe | % hash

    popd
}

function global:au_AfterUpdate($package) {
    pushd "$psscriptroot"

# Update README.md with file.exe --help.
    $skip = $false
    Get-Content README.md | %{
        if (-not $skip) { $_ }
        if ($_ -match '^\$ file --help$') {
            if($IsWindows) {
                tools/x86/file.exe --help
            }
            else {
                wine tools/x86/file.exe --help 2> /dev/null
            }
            $skip = $true
        }
        elseif ($skip -and ($_ -match '^```$')) {
            $_
            $skip = $false
        }
    } > new.README
    Move-Item -force new.README README.md

    popd

    Set-DescriptionFromReadme $package

    pushd "$psscriptroot"

# Update <releaseNotes> in .nuspec.
    $skip = $false
    Get-Content file.nuspec | %{
        if (-not $skip) { $_ }
        if ($_ -match '<releaseNotes>') {
            $Latest.ReleaseNotes
            $skip = $true
        }
        elseif ($skip -and ($_ -match '</releaseNotes>')) {
            $_
            $skip = $false
        }
    } > new.nuspec
    Move-Item -force new.nuspec file.nuspec

    popd
}

Update-Package -ChecksumFor None -NoReadme
