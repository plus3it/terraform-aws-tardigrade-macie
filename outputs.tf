output "macie_account" {
  description = "Macie account"
  value       = aws_macie2_account.this
}
output "classification_job" {
  description = "Macie classification_job"
  value       = var.classification_job != null ? aws_macie2_classification_job.this : null
}

output "custom_data_identifier" {
  description = "Macie custom_data_identifier"
  value       = var.custom_data_identifier != null ? aws_macie2_custom_data_identifier.this : null
}

output "findings_filter" {
  description = "Macie findings_filter"
  value       = var.findings_filter != null ? aws_macie2_findings_filter.this : null
}
