# ============================================
#   DEPLOY SCRIPT
#   Azure VWAN NVA BGP Lab
#   Author: Sathish Kumar Mani
# ============================================

param(
    [string]$VmPassword = 'Lab@Azure2024!',
    [string]$Location   = 'uksouth',
    [string]$LabName    = 'vwan-nva-bgp-lab'
)

Write-Host "=== Azure VWAN NVA BGP Lab ===" -ForegroundColor Cyan
Write-Host "Location : $Location" -ForegroundColor Yellow
Write-Host "Lab Name : $LabName" -ForegroundColor Yellow

# Step 1 - Validate
Write-Host "Step 1: Validating..." -ForegroundColor Yellow
az deployment sub validate `
  --location $Location `
  --template-file ..\main.bicep `
  --parameters ..\parameters\lab.json `
  --parameters parVmPassword=$VmPassword

if ($LASTEXITCODE -ne 0) {
    Write-Host "Validation FAILED! Fix errors first!" -ForegroundColor Red
    exit 1
}
Write-Host "Validation PASSED!" -ForegroundColor Green

# Step 2 - Deploy
Write-Host "Step 2: Deploying..." -ForegroundColor Yellow
az deployment sub create `
  --name $LabName `
  --location $Location `
  --template-file ..\main.bicep `
  --parameters ..\parameters\lab.json `
  --parameters parVmPassword=$VmPassword `
  --verbose

Write-Host "=== Done! ===" -ForegroundColor Green
