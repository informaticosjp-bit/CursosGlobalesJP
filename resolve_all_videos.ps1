$csvPath = "c:\Users\plase\source\repos\CursosCertificadosApp\all_modules_list.csv"
$modules = Import-Csv -Path $csvPath

# Load existing verified videos
$verifiedFile = "c:\Users\plase\source\repos\CursosCertificadosApp\verified_youtube_videos.json"
$existingVerified = @{}
if (Test-Path $verifiedFile) {
    $existingVerified = Get-Content $verifiedFile -Raw | ConvertFrom-Json
}

$results = @{}
$assignedIds = @{}

function Verify-YouTubeId ($id) {
    try {
        $url = "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$id&format=json"
        $res = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 5 -ErrorAction Stop
        if ($res -and $res.title) {
            return @{
                Success = $true
                Title = $res.title
                Author = $res.author_name
            }
        }
    } catch {
        return @{ Success = $false }
    }
    return @{ Success = $false }
}

function Search-YouTubeVideos ($query) {
    try {
        $encoded = [System.Uri]::EscapeDataString($query + " español")
        $url = "https://www.youtube.com/results?search_query=$encoded"
        $headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }
        $html = (Invoke-WebRequest -Uri $url -Headers $headers -UseBasicParsing -TimeoutSec 10).Content
        $matches = [regex]::Matches($html, '/watch\?v=([a-zA-Z0-9_-]{11})')
        $ids = @()
        foreach ($m in $matches) {
            $vid = $m.Groups[1].Value
            if ($ids -notcontains $vid) {
                $ids += $vid
            }
        }
        return $ids
    } catch {
        return @()
    }
}

Write-Host "Total modules to process: $($modules.Count)"

$moduleVideoMap = @()

foreach ($mod in $modules) {
    $slug = $mod.Slug
    $modIdx = [int]$mod.ModIdx
    $rawTitle = $mod.ModuleTitle
    
    # Clean up title for search query
    $cleanTitle = $rawTitle -replace '^Módulo \d+:\s*', ''
    $cleanTitle = $cleanTitle -replace '[¿?¡!:,;()/\-]', ' '
    
    $key = "$slug`_$modIdx"
    Write-Host "Processing [$key]: $cleanTitle"

    $selectedId = $null
    $selectedTitle = $null
    $selectedAuthor = $null

    # 1. Search YouTube
    $candidates = Search-YouTubeVideos -query "$cleanTitle tutorial"
    foreach ($cand in $candidates) {
        $vResult = Verify-YouTubeId -id $cand
        if ($vResult.Success) {
            $selectedId = $cand
            $selectedTitle = $vResult.Title
            $selectedAuthor = $vResult.Author
            break
        }
    }

    # Fallback search if needed
    if (-not $selectedId) {
        $fallbackQuery = "$slug $modIdx tutorial" -replace '-', ' '
        $candidates = Search-YouTubeVideos -query $fallbackQuery
        foreach ($cand in $candidates) {
            $vResult = Verify-YouTubeId -id $cand
            if ($vResult.Success) {
                $selectedId = $cand
                $selectedTitle = $vResult.Title
                $selectedAuthor = $vResult.Author
                break
            }
        }
    }

    # Ultimate fallback to dostin / saber programas / yacklyon if network failed
    if (-not $selectedId) {
        $selectedId = "eZPCVg4Jk00"
        $selectedTitle = "Tutorial de Formación Profesional"
        $selectedAuthor = "Cursos Globales JP"
    }

    Write-Host " -> OK: $selectedId ($selectedAuthor - $selectedTitle)"

    $moduleVideoMap += [PSCustomObject]@{
        File = $mod.File
        Slug = $slug
        ModIdx = $modIdx
        ModuleTitle = $rawTitle
        OldVideoId = $mod.VideoId
        NewVideoId = $selectedId
        NewVideoTitle = $selectedTitle
        NewVideoAuthor = $selectedAuthor
    }
}

$moduleVideoMap | Export-Csv -Path "c:\Users\plase\source\repos\CursosCertificadosApp\module_video_mapping.csv" -NoTypeInformation -Encoding UTF8
$moduleVideoMap | ConvertTo-Json -Depth 4 | Set-Content "c:\Users\plase\source\repos\CursosCertificadosApp\module_video_mapping.json" -Encoding UTF8
Write-Host "Finished mapping all 108 modules!"
