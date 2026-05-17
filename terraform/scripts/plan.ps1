param(
  [string]$LabPath = "terraform/labs/getting-started"
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "load-env.ps1")

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$terraformDir = (Resolve-Path (Join-Path $repoRoot $LabPath)).Path

terraform -chdir="$terraformDir" init -input=false
terraform -chdir="$terraformDir" plan -out tfplan