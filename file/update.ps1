import-module au

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

    $full_changelog = iwr $changelog_url | %{ $_.content -split "`n" } | ?{ $_ -match '^\s+\*' } | %{ $_ -replace '^\s+','' } | select -skip 1

    foreach ($entry in $full_changelog) {
        if ($entry -match '\* release ') {
            break;
        }
        $entry
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/rkitover/file-windows/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/file_[\d.]+-x86_64\.7z' | Select-Object -First 1 -expand href
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
    set-alias 7z $env:chocolateyInstall/tools/7z.exe

    mkdir $psscriptroot/tools -ea ignore | out-null

    pushd $psscriptroot/tools

    ri -recurse -force * -ea ignore

    mkdir x64,x86 -ea ignore | out-null

    iwr $Latest.Url64 -outfile file-x86_64.7z
    iwr $Latest.Url32 -outfile file-x86_32.7z

    7z x file-x86_64.7z | out-null
    mi file.exe x64

    7z x file-x86_32.7z | out-null
    mi file.exe x86

    ri *.7z

    $Latest.Checksum64 = get-filehash x64/file.exe | % hash
    $Latest.Checksum32 = get-filehash x86/file.exe | % hash

    popd
}

function global:au_AfterUpdate($package) {
    pushd "$psscriptroot"

# Update README.md with file.exe --help.
    $skip = $false
    gc README.md | %{
        if (-not $skip) { $_ }
        if ($_ -match '^\$ file --help$') {
            tools/x86/file.exe --help
            $skip = $true
        }
        elseif ($skip -and ($_ -match '^```$')) {
            $_
            $skip = $false
        }
    } > new.README
    mi -force new.README README.md

    popd

    Set-DescriptionFromReadme $package

    pushd "$psscriptroot"

# Update <releaseNotes> in .nuspec.
    $skip = $false
    gc file.nuspec | %{
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
    mi -force new.nuspec file.nuspec

    popd
}

Update-Package -ChecksumFor None -NoReadme
