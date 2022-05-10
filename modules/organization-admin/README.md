# terraform-aws-tardigrade-macie/organization_admin

Terraform module for managing a Macie org_admin_account.
Creates a Macie org administrator account in an AWS organization.  Once created, all AWS accounts added to the AWS organization will be enrolled in Macie and managed by the delegated Macie org administrator account
- Creates a Macie account in the org's Macie administrator account
- Create the organization's Macie administrator account

Prerequisites:  The AWS org must already exist

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_aws.macie_administrator"></a> [aws.macie\_administrator](#provider\_aws.macie\_administrator) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.macie_administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_account_id"></a> [admin\_account\_id](#input\_admin\_account\_id) | (Required) The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_admin_account"></a> [organization\_admin\_account](#output\_organization\_admin\_account) | Macie Organization Admin Account |

<!-- END TFDOCS -->
