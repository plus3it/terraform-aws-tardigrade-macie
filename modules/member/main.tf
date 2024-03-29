# Invites a member account to join an administrator account Macie organization.
# - Creates a Macie account in the member AWS account
# - Creates a macie member resource in the administrator account which imnvites the member account to join the administrator account Macie organization.
# - Creates a Macie invite accepter in the member account to accept the invite from the administrator account
#
# Prerequisites:  The administrator AWS account's Macie account must already be enabled

# Creates a Macie account in the member (this) AWS account
resource "aws_macie2_account" "this" {
  finding_publishing_frequency = var.finding_publishing_frequency
  status                       = var.status
}

# Create Macie member in the administrator account
resource "aws_macie2_member" "this" {
  provider = aws.administrator

  account_id                            = aws_macie2_account.this.id
  email                                 = var.member.email
  invite                                = true
  invitation_message                    = var.member.invitation_message
  invitation_disable_email_notification = var.member.invitation_disable_email_notification
  status                                = var.status
  tags                                  = var.member.tags
}

# Create macie invite accepter in the member account
resource "aws_macie2_invitation_accepter" "this" {
  administrator_account_id = aws_macie2_member.this.administrator_account_id
}
