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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delegated_administrator_account_id"></a> [delegated\_administrator\_account\_id](#input\_delegated\_administrator\_account\_id) | (Required) The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the AWS organization. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_admin_account"></a> [organization\_admin\_account](#output\_organization\_admin\_account) | Macie Organization Admin Account |

<!-- END TFDOCS -->
