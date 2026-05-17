# Copilot Instructions

- Terraform code lives in `terraform/labs/<lab-name>`.
- Runtime and lab implementation code lives in `labs/<lab-name>`.
- Terraform launchers live in `terraform/scripts`.
- Use `getting-started` as the default quickstart lab.
- Keep Terraform state isolated per lab folder.
- Prefer service-specific Terraform files like `vpc.tf`, `s3.tf`, and `lambda.tf`.
- Use `terraform/scripts/*.cmd` on Windows for plan/apply/destroy.
- Launchers accept `-LabPath` and default to `terraform/labs/getting-started`.
- Do not commit `.env` or lab-specific `terraform.tfvars` files.
- Update `README.md` when the workflow or layout changes.
