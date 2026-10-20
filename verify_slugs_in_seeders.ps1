$seeders = @(
    "CursosCertificadosApp\Data\CurriculumSeeder.cs",
    "CursosCertificadosApp\Data\CurriculumSeeder.Tech.cs",
    "CursosCertificadosApp\Data\BusinessFundamentalsSeeder.cs",
    "CursosCertificadosApp\Data\NewPracticalCoursesSeeder.cs"
)

$slugs = @(
    "domina-la-ia-con-gemini", "introduccion-ciberseguridad", "servicio-tecnico-informatico-soporte-sistemas", "ti-para-el-exito-empresarial",
    "office-basico", "excel-avanzado", "power-bi", "ciencia-y-analisis-de-datos", "office-intermedio",
    "sap-business-one-b1-gestion-operativa", "shopify-comercio-electronico-tiendas-online", "asistente-de-ventas-comercial-supervision", "mercaderista-trade-merchandising-punto-venta", "ventas-en-linea",
    "administracion-empresarial-procesos-reportes", "administracion-de-inventario", "auxiliar-almacen-inventarios-logistica", "gestion-proyectos-agile", "planificacion-estrategica",
    "filosofia-empresarial-etica-laboral", "atencion-al-cliente-presencial-fidelizacion", "atencion-al-cliente", "trabajo-en-equipo-habilidades-blandas-productividad", "liderazgo-efectivo", "tacticas-de-negociacion-efectiva", "gestion-del-tiempo", "primeros-auxilios"
)

foreach ($slug in $slugs) {
    $foundIn = @()
    foreach ($seeder in $seeders) {
        $c = [System.IO.File]::ReadAllText($seeder, [System.Text.Encoding]::UTF8)
        if ($c -match ('Slug\s*=\s*"' + [regex]::Escape($slug) + '"')) {
            $foundIn += [System.IO.Path]::GetFileName($seeder)
        }
    }
    Write-Host "$slug -> $($foundIn -join ', ')"
}
