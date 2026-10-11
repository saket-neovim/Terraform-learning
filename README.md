# Terraform Foundations and Azure Practice

Terraform learning exercises for Azure resource groups, virtual networks, subnets, NSGs, structured inputs, imports, reusable modules, and custom role definitions.

**Status:** this repository contains practice configurations at different stages. It has no committed deployment evidence or automated test suite; examples should be reviewed before use.

## Repository guide

| Location | Purpose |
| --- | --- |
| [Root configuration](main.tf) | Basic Azure network and security-rule exercises |
| [development](development/) | Additional early networking practice |
| [Labs 06–09](lab-06/) | Variables, structured network inputs, and network resources; inspect each numbered folder independently |
| [Lab 10](lab-10/) | Importing an existing VNet, subnet, and NSG |
| [Lab 11](lab-11/) | Subnet maps and repeated resources |
| [Lab 12](lab-12/) | Resource-group modules and scoped custom roles |
| [Shared modules](modules/) | Resource group and role-definition interfaces |

Each root has its own inputs and provider requirements. Some use AzureRM 3.x and others use 4.x; do not treat them as a single root module or upgrade them together without review.

## Prerequisites and local checks

Install Git, Azure CLI, and a Terraform version matching the chosen root's provider/version declarations. Azure planning requires access to a disposable subscription with the necessary permissions; creating custom roles requires additional RBAC rights.

```bash
az login
az account set --subscription '<your-subscription-id>'
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
export ARM_TENANT_ID="$(az account show --query tenantId -o tsv)"
terraform init
terraform fmt -check
terraform validate
```

Run these commands from the root or one chosen lab directory. Review its `variables.tf`, supply required values through an ignored local `.tfvars` file, and inspect `terraform plan` before deployment.

### Import exercise

Lab 10 accepts `import_vnet_id`, `import_subnet_id`, and `import_nsg_id` as local inputs instead of embedding subscription IDs. All three must refer to your own existing lab resources. Align `prefix`, resource-group names, network names, and address ranges with those resources before reviewing the plan. Import does not guarantee a no-change plan.

## What to examine

- How references between resources determine dependency order.
- How maps and modules affect resource addresses and input contracts.
- Why custom-role management actions differ from blob data actions.
- Which changes Terraform proposes after an import or input change.

These are discussion topics supported by the configuration, not claims of production deployment. Network rules, role scopes, and module behavior still need validation in the intended environment.

## Security and cleanup

The previously tracked `lab-12/tfplan` is removed from the current tree. Saved plans can embed configuration and state; older commits still retain that artifact until a separately reviewed history cleanup.

Keep `.tfvars`, state, saved plans, and credentials out of Git. Provider lock files remain tracked. Use dummy data, reviewed plans, and short-lived resources.

Before cleanup, identify which state owns each resource and whether any imported resource should be retained. Review `terraform plan -destroy` before `terraform destroy`, and inspect Azure afterward for remaining resources. No cloud deployment is required to read or statically review these exercises.
