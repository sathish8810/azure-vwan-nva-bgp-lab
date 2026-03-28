# ============================================
#   VALIDATION SCRIPT
#   Run before deploying!
# ============================================

Write-Host "=== Running Validation ===" -ForegroundColor Cyan

# Check all 5 fixes
$file = "..\resources.bicep"

if (!(Select-String -Path $file -Pattern "resWait"))
  { Write-Host "Fix 1 OK: resWait removed!" -ForegroundColor Green }
else { Write-Host "Fix 1 MISSING!" -ForegroundColor Red; exit 1 }

if (Select-String -Path $file -Pattern "VpnGw1AZ")
  { Write-Host "Fix 2 OK: VpnGw1AZ found!" -ForegroundColor Green }
else { Write-Host "Fix 2 MISSING!" -ForegroundColor Red; exit 1 }

if (Select-String -Path $file -Pattern "Generation2")
  { Write-Host "Fix 3 OK: Generation2 found!" -ForegroundColor Green }
else { Write-Host "Fix 3 MISSING!" -ForegroundColor Red; exit 1 }

if (Select-String -Path $file -Pattern "resVpnConnectionHub1Branch1")
  { Write-Host "Fix 4 OK: BGP VPN Connection found!" -ForegroundColor Green }
else { Write-Host "Fix 4 MISSING!" -ForegroundColor Red; exit 1 }

if (Select-String -Path $file -Pattern "zones:")
  { Write-Host "Fix 5 OK: PIP Zones found!" -ForegroundColor Green }
else { Write-Host "Fix 5 MISSING!" -ForegroundColor Red; exit 1 }

Write-Host "All fixes verified!" -ForegroundColor Green

# Azure Validation
Write-Host "Running Azure validation..." -ForegroundColor Yellow
az deployment sub validate `
  --location uksouth `
  --template-file ..\main.bicep `
  --parameters ..\parameters\lab.json `
  --parameters parVmPassword='Lab@Azure2024!'

Write-Host "=== Validation Complete! ===" -ForegroundColor Green
