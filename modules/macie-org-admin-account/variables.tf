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

variable "admin_account_id" {
  description = "(Required) The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization."
  type        = string
}
