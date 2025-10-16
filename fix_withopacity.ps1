# Fix withOpacity to withValues in all Dart files

$files = @(
    "lib\screens\anomaly_dashboard_screen.dart",
    "lib\screens\bigquery_export_screen.dart",
    "lib\screens\direct_chat_screen.dart",
    "lib\screens\gamification\leaderboard_screen.dart",
    "lib\screens\gamification\module_detail_screen.dart",
    "lib\screens\hris_import_screen.dart",
    "lib\screens\import_history_screen.dart",
    "lib\screens\message_thread_screen.dart",
    "lib\screens\moderation_queue_screen.dart",
    "lib\widgets\chat\message_bubble.dart",
    "lib\widgets\gamification\progress_card.dart",
    "lib\widgets\recommendation_card.dart"
)

foreach ($file in $files) {
    $fullPath = Join-Path $PSScriptRoot $file
    if (Test-Path $fullPath) {
        Write-Host "Processing: $file"
        $content = Get-Content -Path $fullPath -Raw
        $content = $content -replace '\.withOpacity\(', '.withValues(alpha: '
        Set-Content -Path $fullPath -Value $content -NoNewline
    } else {
        Write-Host "File not found: $file" -ForegroundColor Yellow
    }
}

Write-Host "`nDone! All files processed." -ForegroundColor Green
