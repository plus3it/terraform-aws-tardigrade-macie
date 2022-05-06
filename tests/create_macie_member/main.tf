# The provider account for the Macie member account
provider "aws" {
  region  = "us-east-1"
  profile = "plus3it-member" # Profile must exist in your .aws/config
}

# AWS provider account for the Macie primary account
provider "aws" {
  region  = "us-east-1"
  alias   = "administrator"
  profile = "plus3it-management" # Profile must exist in your .aws/config
}

# Create Macie account for the administrator AWS account
resource "aws_macie2_account" "administrator" {
  provider = aws.administrator

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"
}

# Invite this member account to join the administrator account Macie organization.
# - Creates a Macie account for the member AWS account
# - Creates a Macie member resource in the administrator AWS account which imnvites the member account to join the administrator account Macie organization.
# - Creates a Macie invite accepter in the member account to accept the invite from the administrator account
module "macie_member" {
  source = "../../modules/macie-member-account"

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"

  providers = {
    aws               = aws
    aws.administrator = aws.administrator
  }

  member = {
    email                                 = "aws-accounts+tardigrade-dev-tenant-001@plus3it.com"
    invite                                = true
    status                                = "ENABLED"
    invitation_message                    = "You are invited to join Macie"
    invitation_disable_email_notification = true
    tags                                  = null
  }

  depends_on = [aws_macie2_account.administrator]
}
