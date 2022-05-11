variable "finding_publishing_frequency" {
  description = "(Optional) Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN_MINUTES, ONE_HOUR or SIX_HOURS."
  type        = string
  default     = "SIX_HOURS"
  validation {
    condition     = var.finding_publishing_frequency != null ? contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.finding_publishing_frequency) : true
    error_message = "The aws_macie2_account finding_publishing_frequency value is not valid. Valid values: FIFTEEN_MINUTES, ONE_HOUR, or SIX_HOURS."
  }
}

variable "status" {
  description = "(Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED."
  type        = string
  default     = "ENABLED"
  validation {
    condition     = var.status != null ? contains(["ENABLED", "PAUSED"], var.status) : true
    error_message = "The aws_macie2_account status value is not valid. Valid values: ENABLED, and PAUSED."
  }
}

variable "member" {
  description = "Macie member"
  type = object({
    email                                 = string      # (Required) Email address for member account.
    status                                = string      # (Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED.
    invite                                = string      # ((Optional) Boolean whether to invite the account to GuardDuty as a member. Defaults to false.
    invitation_message                    = string      # (Optional) A custom message to include in the invitation. Amazon Macie adds this message to the standard content that it sends for an invitation.
    invitation_disable_email_notification = bool        # (Optional) Specifies whether to send an email notification to the root user of each account that the invitation will be sent to. This notification is in addition to an alert that the root user receives in AWS Personal Health Dashboard. To send an email notification to the root user of each account, set this value to true.
    tags                                  = map(string) # (Optional) A map of key-value pairs that specifies the tags to associate with the account in Amazon Macie.
  })
  default = null
}
