# Fix all TimestampConverter to RequiredTimestampConverter for non-nullable DateTime fields

$files = @(
    "lib\models\token.dart",
    "lib\models\recommendation.dart",
    "lib\models\moderation.dart",
    "lib\models\message_search.dart",
    "lib\models\message_reaction.dart",
    "lib\models\hris_import.dart",
    "lib\models\chat_room.dart",
    "lib\models\chat_message.dart",
    "lib\models\certificate.dart",
    "lib\models\bigquery_export.dart",
    "lib\models\anomaly.dart"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $newContent = $content -replace '@TimestampConverter\(\) required DateTime', '@RequiredTimestampConverter() required DateTime'
        Set-Content $file -Value $newContent -NoNewline
        Write-Host "Fixed: $file" -ForegroundColor Green
    } else {
        Write-Host "Not found: $file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "All files fixed! Now run:" -ForegroundColor Cyan
Write-Host "dart run build_runner build --delete-conflicting-outputs" -ForegroundColor Yellow

