# Repo Instructions

## Purpose
This repository contains AWS hands-on labs provisioned with Terraform.

## Layout
- Terraform code lives under `terraform/labs/<lab-name>`.
- Runtime or lab implementation code lives under `labs/<lab-name>`.
- Terraform launchers live under `terraform/scripts`.
- The default quickstart lab is `getting-started`.

## Conventions
- Keep Terraform state isolated per lab folder.
- Prefer service-specific Terraform files inside each lab (for example `s3.tf`, `vpc.tf`, `lambda.tf`).
- Keep root-level Terraform files out of the repo root.
- Use `terraform/scripts/*.cmd` on Windows so launches work even when PowerShell script execution is restricted.
- Launchers accept `-LabPath` and should default to `terraform/labs/getting-started`.

## Common Commands
```powershell
./terraform/scripts/plan.cmd -LabPath terraform/labs/getting-started
./terraform/scripts/apply.cmd -LabPath terraform/labs/getting-started
./terraform/scripts/destroy.cmd -LabPath terraform/labs/getting-started
```

## Notes for Future Changes
- If you add a new lab, create a new folder under `terraform/labs/<lab-name>` and keep its state inside that folder.
- Update `README.md` when workflow or layout conventions change.
- Never commit `.env` or lab-specific `terraform.tfvars` files.
