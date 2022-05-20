output "account" {
  description = "Macie account"
  value       = aws_macie2_account.this
}
output "classification_job" {
  description = "Macie classification_job"
  value       = aws_macie2_classification_job.this
}

output "custom_data_identifier" {
  description = "Macie custom_data_identifier"
  value       = aws_macie2_custom_data_identifier.this
}

output "findings_filter" {
  description = "Macie findings_filter"
  value       = aws_macie2_findings_filter.this
}
