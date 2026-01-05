# Script para probar API local
$url = "http://localhost:3000/chat"
$json = '{
    "messages": [
        {
            "role": "user",
            "content": "Resuelve Fibonacci en javascript"
        }
    ]
}'

Write-Host "Enviando petición a: $url" -ForegroundColor Cyan
Write-Host "Body: $json`n" -ForegroundColor Gray

try {
    # Intentar con curl.exe primero
    Write-Host "Intentando con curl.exe..." -ForegroundColor Yellow
    $result = curl.exe -X POST $url `
        -H "Content-Type: application/json" `
        -d $json
    
    Write-Host "Respuesta:`n" -ForegroundColor Green
    $result
}
catch {
    Write-Host "curl.exe falló, usando Invoke-WebRequest..." -ForegroundColor Yellow
    
    try {
        $response = Invoke-WebRequest -Method Post -Uri $url `
            -ContentType "application/json" `
            -Body $json `
            -ErrorAction Stop
        
        Write-Host "✅ Éxito! Status: $($response.StatusCode)" -ForegroundColor Green
        Write-Host "Respuesta:`n$($response.Content)" -ForegroundColor White
    }
    catch {
        Write-Host "❌ Error:" $_.Exception.Message -ForegroundColor Red
    }
}