# TVT Future Build & Deploy Script
# PowerShell script for Windows

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "   TVT Future Build & Deploy Tool   " -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if a command exists
function Test-Command {
    param($command)
    try {
        if (Get-Command $command -ErrorAction Stop) {
            return $true
        }
    }
    catch {
        return $false
    }
}

# Check Java
Write-Host "Checking Java..." -ForegroundColor Yellow
if (Test-Command "java") {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✓ Java found: $javaVersion" -ForegroundColor Green
} else {
    Write-Host "✗ Java not found! Please install JDK 17 or higher" -ForegroundColor Red
    exit 1
}

# Check Ant
Write-Host "Checking Apache Ant..." -ForegroundColor Yellow
if (Test-Command "ant") {
    $antVersion = ant -version
    Write-Host "✓ Ant found: $antVersion" -ForegroundColor Green
} else {
    Write-Host "⚠ Ant not found. Using NetBeans is recommended" -ForegroundColor Yellow
}

# Menu
Write-Host ""
Write-Host "Select an option:" -ForegroundColor Cyan
Write-Host "1. Clean project" -ForegroundColor White
Write-Host "2. Build project" -ForegroundColor White
Write-Host "3. Clean and Build" -ForegroundColor White
Write-Host "4. Check database connection" -ForegroundColor White
Write-Host "5. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter your choice (1-5)"

switch ($choice) {
    "1" {
        Write-Host "`nCleaning project..." -ForegroundColor Yellow
        if (Test-Path "build") {
            Remove-Item -Path "build" -Recurse -Force
            Write-Host "✓ Build folder cleaned" -ForegroundColor Green
        }
        if (Test-Path "dist") {
            Remove-Item -Path "dist" -Recurse -Force
            Write-Host "✓ Dist folder cleaned" -ForegroundColor Green
        }
        Write-Host "✓ Clean completed!" -ForegroundColor Green
    }
    "2" {
        Write-Host "`nBuilding project..." -ForegroundColor Yellow
        if (Test-Command "ant") {
            ant build
            Write-Host "✓ Build completed!" -ForegroundColor Green
        } else {
            Write-Host "✗ Ant not found. Please use NetBeans IDE to build" -ForegroundColor Red
        }
    }
    "3" {
        Write-Host "`nCleaning and building project..." -ForegroundColor Yellow
        if (Test-Command "ant") {
            ant clean build
            Write-Host "✓ Clean and build completed!" -ForegroundColor Green
            Write-Host "`nWAR file location: dist/tvtfuture.war" -ForegroundColor Cyan
        } else {
            Write-Host "✗ Ant not found. Please use NetBeans IDE to build" -ForegroundColor Red
        }
    }
    "4" {
        Write-Host "`nChecking database connection..." -ForegroundColor Yellow
        Write-Host "Database: TVT_Future" -ForegroundColor White
        Write-Host "Server: localhost:1433" -ForegroundColor White
        Write-Host "`nNote: Make sure SQL Server is running and credentials are correct in persistence.xml" -ForegroundColor Yellow
    }
    "5" {
        Write-Host "`nGoodbye!" -ForegroundColor Green
        exit 0
    }
    default {
        Write-Host "`n✗ Invalid choice!" -ForegroundColor Red
    }
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
