# Terraform Workflow

This README outlines the basic Terraform workflow for initializing, planning, applying, and destroying infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- Properly configured environment with access to the required credentials (e.g., AWS, GCP, Azure).

## Steps

```bash
# 1. Initialize Terraform and upgrade providers

terraform init -upgrade

# 2. Create a plan to provision infrastructure

terraform plan -out main.tfplan

# 3. Apply the infrastructure changes

terraform apply main.tfplan

# 4. Create a plan to destroy infrastructure

terraform plan -destroy -out main.destroy.tfplan

# 5. Apply the destroy plan to remove infrastructure

terraform apply main.destroy.tfplan
