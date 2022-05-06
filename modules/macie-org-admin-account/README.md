# terraform-aws-tardigrade-macie/org_admin_account

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
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | (Optional) Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN\_MINUTES, ONE\_HOUR or SIX\_HOURS. | `string` | `"SIX_HOURS"` | no |
| <a name="input_status"></a> [status](#input\_status) | (Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED. | `string` | `"ENABLED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_admin_account"></a> [org\_admin\_account](#output\_org\_admin\_account) | Macie Organization Admin Account |

<!-- END TFDOCS -->
