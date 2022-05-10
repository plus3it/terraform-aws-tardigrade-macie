# terraform-aws-tardigrade-macie/member

Terraform module for managing a Macie member_account.

## Testing

You can find example implementations of this module in the tests folder (create_macie_member). This module requires 2 different AWS accounts to test. 

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
| <a name="provider_aws.administrator"></a> [aws.administrator](#provider\_aws.administrator) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | (Optional) Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN\_MINUTES, ONE\_HOUR or SIX\_HOURS. | `string` | `"SIX_HOURS"` | no |
| <a name="input_member"></a> [member](#input\_member) | Macie member | <pre>object({<br>    email                                 = string      # (Required) Email address for member account.<br>    status                                = string      # (Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED.<br>    invite                                = string      # ((Optional) Boolean whether to invite the account to GuardDuty as a member. Defaults to false.<br>    invitation_message                    = string      # (Optional) A custom message to include in the invitation. Amazon Macie adds this message to the standard content that it sends for an invitation.<br>    invitation_disable_email_notification = bool        # (Optional) Specifies whether to send an email notification to the root user of each account that the invitation will be sent to. This notification is in addition to an alert that the root user receives in AWS Personal Health Dashboard. To send an email notification to the root user of each account, set this value to true.<br>    tags                                  = map(string) # (Optional) A map of key-value pairs that specifies the tags to associate with the account in Amazon Macie.<br>  })</pre> | `null` | no |
| <a name="input_status"></a> [status](#input\_status) | (Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED. | `string` | `"ENABLED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account"></a> [account](#output\_account) | Macie account |
| <a name="output_invite_accepter"></a> [invite\_accepter](#output\_invite\_accepter) | Macie aws\_macie\_invite\_accepter |
| <a name="output_member"></a> [member](#output\_member) | Macie member configuration |

<!-- END TFDOCS -->
