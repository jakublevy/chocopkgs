# Author: TheCakeIsNaOH
# License: Apache License 2.0
# Source repo: https://github.com/TheCakeIsNaOH/chocolatey-packages

function Get-GitHubLatestReleaseLinks() {
    param(
      [parameter(Mandatory=$true)][string]$user,
      [parameter(Mandatory=$true)][string]$repository,
      [switch]$absolutelatestrelease
    )
    
    if ($absolutelatestrelease) {
      $releases_url = "https://github.com/" + $user + "/" + $repository + "/releases"
      $releases_page = Invoke-WebRequest -Uri $releases_url -UseBasicParsing
      $release_tag_url = "https://github.com" + ($releases_page.links | Where-Object href -match "/tag/v" | Select-Object -First 1 -ExpandProperty href)
    } else {
      $latest_releases_url = "https://github.com/" + $user + "/" + $repository + "/releases/latest"
      $release_tag_url = Get-RedirectedUrl -url $latest_releases_url
    }
  
    $expanded_assets_url = $release_tag_url -replace "/tag/","/expanded_assets/"
    $assets_page = Invoke-WebRequest -Uri $expanded_assets_url -UseBasicParsing
    return $assets_page
  }

# https://stackoverflow.com/questions/63042390/getting-the-final-redirected-url-from-within-powershell
function Get-RedirectedUrl {
    Param (
        [Parameter(Mandatory=$true)]
        [String]$url
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$true
    $request.UserAgent = 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) AppleWebKit/534.6 (KHTML, like Gecko) Chrome/7.0.500.0 Safari/534.6'
    
    try
    {
        $response = $request.GetResponse()
        $response.ResponseUri.AbsoluteUri
        $response.Close()
    }
    catch
    {
        "Error: $_"
    }
}
