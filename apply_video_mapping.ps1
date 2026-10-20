$mappingJson = Get-Content "c:\Users\plase\source\repos\CursosCertificadosApp\module_video_mapping.json" -Raw -Encoding UTF8 | ConvertFrom-Json

# Group mapping by File and Slug
$byFile = $mappingJson | Group-Object File

foreach ($fg in $byFile) {
    $filePath = Join-Path "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data" $fg.Name
    if (-not (Test-Path $filePath)) {
        Write-Warning "File not found: $filePath"
        continue
    }

    Write-Host "Processing file: $($fg.Name)"
    $content = Get-Content $filePath -Raw -Encoding UTF8

    # Process each course in this file
    $coursesInFile = $fg.Group | Group-Object Slug

    foreach ($cg in $coursesInFile) {
        $slug = $cg.Name
        Write-Host "  Updating course: $slug"

        # Find the course block in the content
        # We split by 'new UpgradeCourseData' and match the course with this slug
        $coursePattern = '(?s)(Slug\s*=\s*"' + [regex]::Escape($slug) + '".*?)(?=(?:new UpgradeCourseData|$))'
        $courseMatch = [regex]::Match($content, $coursePattern)

        if (-not $courseMatch.Success) {
            Write-Warning "    Could not find course block for $slug"
            continue
        }

        $courseBlock = $courseMatch.Value
        $updatedCourseBlock = $courseBlock

        # Now within the course block, find each module (ordered by ModIdx 1..4)
        $mods = $cg.Group | Sort-Object ModIdx
        
        # Split courseBlock by 'new UpgradeModuleData'
        $modParts = [regex]::Split($updatedCourseBlock, '(?=new UpgradeModuleData)')
        # modParts[0] is course header before first module
        # modParts[1..N] are the modules

        if ($modParts.Count -ge ($mods.Count + 1)) {
            for ($m = 0; $m -lt $mods.Count; $m++) {
                $modInfo = $mods[$m]
                $partIdx = $m + 1
                $partText = $modParts[$partIdx]

                $cleanTitle = $modInfo.NewVideoTitle -replace '["\\]', ''
                $newIframe = '<iframe src=""https://www.youtube.com/embed/' + $modInfo.NewVideoId + '"" title=""' + $cleanTitle + '"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>'

                # Replace iframe in this module part
                $iframePattern = '<iframe\s+src=""https?://[^""]*embed/[a-zA-Z0-9_-]{11}""[^>]*></iframe>'
                if ($partText -match $iframePattern) {
                    $modParts[$partIdx] = [regex]::Replace($partText, $iframePattern, $newIframe, 1)
                    Write-Host "    Mod $($modInfo.ModIdx): Replaced with $($modInfo.NewVideoId)"
                } else {
                    Write-Warning "    Mod $($modInfo.ModIdx): iframe pattern not found in module block!"
                }
            }

            $updatedCourseBlock = [string]::Join("", $modParts)
            # Now replace the original course block in $content
            $content = $content.Replace($courseBlock, $updatedCourseBlock)
        } else {
            Write-Warning "    Module parts count ($($modParts.Count)) did not match expected ($($mods.Count + 1))"
        }
    }

    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Saved: $filePath"
}
Write-Host "All files updated with verified videos successfully!"
