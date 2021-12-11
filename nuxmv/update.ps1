import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $cookie = New-Object System.Net.Cookie 
    $cookie.Name = "nuXmv"
    $cookie.Value = "registered"
    $cookie.Domain = "nuxmv.fbk.eu"
    $session.Cookies.Add($cookie);
    $download_page =   Invoke-WebRequest -UseBasicParsing -Uri 'https://nuxmv.fbk.eu/index.php?n=Download.HiddenDownload' -WebSession $session
    if($PSVersionTable.PSEdition -eq 'Core') {
        $content = [system.text.encoding]::UTF8.GetString($download_page.Content)
        $absolute_url64 = [regex]::Match($content, "href=.*(https://.*nuXmv-\d+\.\d+(\.\d+)*-win64.tar\.gz)").Groups[1].Value
    }
    else {
        $absolute_url64  = $download_page.links | Where-Object href -match 'nuXmv-\d+\.\d+(\.\d+)*-win64' | Select-Object -First 1 -expand href
    }
    $absolute_url32  = $absolute_url64.Replace('win64', 'win32')
    $version = [regex]::Match($absolute_url64, 'nuXmv-(\d+\.\d+(\.\d+)*)-win64').Groups[1].Value
    @{
        Version = $version
        Url64   = $absolute_url64
        Url32   = $absolute_url32
    }
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package
