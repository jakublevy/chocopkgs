import-module au

# manual

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://petr.olsak.net/ftp/olsak'
    $no_new_version_available = $download_page.Content -match '2010-02-01 23:04'
    if($no_new_version_available) {
        $version = '1.2'
    }
    else {
        $version = '1.6'
    }
    @{
        Version  = $version
    }
}

update
