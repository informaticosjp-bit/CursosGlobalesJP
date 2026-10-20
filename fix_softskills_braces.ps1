$file = "CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Replace the boundary between courses: `}                },` with `}\r\n                    }\r\n                },`
$patternMid = '}\s*},\s*\r?\n(\s*// =+)'
$replacementMid = "}`r`n                    }`r`n                },`r`n`$1"
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $patternMid, $replacementMid)

# Replace the final boundary
$patternEnd = '}\s*}\s*\r?\n\s*};\s*\r?\n\s*}\s*\r?\n\s*}\s*\r?\n}\s*$'
$replacementEnd = "}`r`n                    }`r`n                }`r`n            };`r`n        }`r`n    }`r`n}`r`n"
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $patternEnd, $replacementEnd)

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Braces fixed successfully in SoftSkillsHR.cs!"
