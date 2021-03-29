import-module au

# manual
function global:au_SearchReplace {
    @{
    }
}

function global:au_GetLatest {
    $version = '1.2'
    $base_url = 'http://petr.olsak.net/ftp/olsak/'
    $regex = [regex]::new('\d{4}-\d{2}-\d{2}')
    $relative_urls = [System.Collections.Queue]::new()
    $relative_urls.Enqueue('vlna/')
    
    while($relative_urls.Count -gt 0) {
        $curr_relative_url = $relative_urls.Dequeue()
        $url = "$base_url$curr_relative_url"
        $response = Invoke-WebRequest -UseBasicParsing -Uri $url

        $sub_dirs = $response.links | % href | ? { $_.EndsWith('/') -And -Not $_.StartsWith('/') }
        $sub_dirs | % { $relative_urls.Enqueue("$curr_relative_url$_") }

        $newest_change = $regex.Matches($response.Content) | % { [datetime]::Parse($_) } | sort -Descending | select -First 1
        if($newest_change.Year -gt 2010) {
            $version = '1.6'
            break
        }
    }

    @{
        Version  = $version
    }
}

update
