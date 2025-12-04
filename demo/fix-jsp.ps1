# Script para corrigir cabecalhos dos arquivos JSP
Write-Host "Corrigindo arquivos JSP..." -ForegroundColor Green

$jspFiles = Get-ChildItem -Path "src\main\webapp" -Filter "*.jsp" -Recurse

$oldPattern1 = '<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>'
$oldPattern2 = '<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>'
$newPattern1 = '<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>'
$newPattern2 = '<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>'

$count = 0

foreach ($file in $jspFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    if ($content -match [regex]::Escape($oldPattern1)) {
        $content = $content -replace [regex]::Escape($oldPattern1), $newPattern1
        $modified = $true
    }
    
    if ($content -match [regex]::Escape($oldPattern2)) {
        $content = $content -replace [regex]::Escape($oldPattern2), $newPattern2
        $modified = $true
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Corrigido: $($file.Name)" -ForegroundColor Yellow
        $count++
    }
}

Write-Host ""
Write-Host "$count arquivo(s) corrigido(s)!" -ForegroundColor Green
Write-Host ""
Write-Host "Limpando cache do Jetty..." -ForegroundColor Green

if (Test-Path "target\tmp") { 
    Remove-Item -Recurse -Force "target\tmp"
    Write-Host "  Cache tmp removido" -ForegroundColor Yellow
}

if (Test-Path "target\work") { 
    Remove-Item -Recurse -Force "target\work"
    Write-Host "  Cache work removido" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Concluido! Execute 'mvn jetty:run' para testar." -ForegroundColor Green

