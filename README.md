# Terraform AWS Test/Dev Environment

This repository provisions a **single AWS environment** for test/dev usage with Terraform.

## What gets created

- VPC
- Public subnet
- Internet Gateway + route table
- Security group (HTTP/HTTPS/SSH ingress)
- S3 bucket (name is randomized to avoid global conflicts)

## Prerequisites

- Terraform `>= 1.6.0`
- AWS credentials configured locally (see [AWS Credentials Setup](#aws-credentials-setup))
- AWS region and profile values in `terraform.tfvars`

## AWS Credentials Setup

Choose **one** of these methods:

### Option 1: Environment Variables (Recommended for local dev)

1. Create a `.env` file in the project root:
```
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
```

2. Load before running Terraform:
```powershell
Get-Content .env | ForEach-Object {
  if ($_ -match '^\s*([^#=]+)=(.*)$') {
    [Environment]::SetEnvironmentVariable($matches[1], $matches[2], 'Process')
  }
}

.\scripts\plan.cmd
```

If your machine has a restrictive PowerShell execution policy, use the `.cmd` launchers in `scripts/` instead of invoking the `.ps1` files directly.

### Option 2: AWS Credentials File

1. Run AWS CLI setup:
```powershell
aws configure --profile default
```
(Stores credentials in `~/.aws/credentials`)

2. Terraform automatically reads from `~/.aws/credentials` using the profile in `terraform.tfvars`.

### Option 3: AWS CLI Profile

Update `terraform.tfvars` with your profile name only if you want Terraform to use a named shared profile:
```hcl
aws_profile = "your-profile-name"
```

If you are using aws login / SSO-backed credentials, leave `aws_profile` unset so Terraform can use the active login session from your AWS CLI environment.

The `scripts/*` launchers will also try to export AWS CLI login credentials into the Terraform process automatically when no `.env` file is present.

**⚠️ IMPORTANT:** Never commit `.env` or `terraform.tfvars` to git (already in `.gitignore`).

## Quick start

1. Copy sample variables:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

2. Update `terraform.tfvars` with your values.

3. Run common operations:

```powershell
.\scripts\plan.cmd
.\scripts\apply.cmd
.\scripts\destroy.cmd
```

## Manual Terraform commands

```powershell
terraform init
terraform plan -out tfplan
terraform apply tfplan
terraform destroy
```
