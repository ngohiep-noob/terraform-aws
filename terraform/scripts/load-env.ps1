# Auto-load AWS credentials from .env file
$envFile = Join-Path $PSScriptRoot "..\..\.env"

if (Test-Path $envFile) {
  Write-Host "Loading credentials from .env..." -ForegroundColor Green
  Get-Content $envFile | Where-Object { $_ -match '^\s*([^#=]+)=(.*)$' } | ForEach-Object {
    $key = $matches[1].Trim()
    $value = $matches[2].Trim()
    [Environment]::SetEnvironmentVariable($key, $value, 'Process')
  }
} else {
  Write-Host ".env file not found. Using existing AWS credentials." -ForegroundColor Yellow
}

if (-not $env:AWS_ACCESS_KEY_ID -and -not $env:AWS_SECRET_ACCESS_KEY) {
  try {
    $exportArgs = @("configure", "export-credentials", "--format", "powershell")

    if (-not [string]::IsNullOrWhiteSpace($env:AWS_PROFILE)) {
      $exportArgs += @("--profile", $env:AWS_PROFILE)
    }

    $credentialScript = & aws @exportArgs

    if ($LASTEXITCODE -eq 0 -and $credentialScript) {
      Write-Host "Exporting credentials from AWS CLI login..." -ForegroundColor Green
      Invoke-Expression (($credentialScript -join [Environment]::NewLine))
    }
  } catch {
    Write-Host "Unable to export AWS CLI credentials: $($_.Exception.Message)" -ForegroundColor Yellow
  }
}