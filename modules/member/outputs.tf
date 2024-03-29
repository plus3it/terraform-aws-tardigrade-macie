output "account" {
  description = "Macie account"
  value       = aws_macie2_account.this
}

output "member" {
  description = "Macie member configuration"
  value       = aws_macie2_member.this
}

output "invite_accepter" {
  description = "Macie aws_macie_invite_accepter"
  value       = aws_macie2_invitation_accepter.this
}
