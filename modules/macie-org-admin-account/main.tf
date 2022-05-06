# Creates a Macie org administrator account in an AWS organization.  Once created, all AWS accounts added to the AWS organization will be enrolled in Macie and managed by the delegated Macie org administrator account
# - Creates a Macie account in the org's Macie administrator account
# - Create the organization's Macie administrator account
#
# Prerequisites:  The AWS org must already exist

# Create Macie account for the organization's GuardDuty administrator account
resource "aws_macie2_account" "macie_administrator" {
  provider                     = aws.macie_administrator
  finding_publishing_frequency = var.finding_publishing_frequency
  status                       = var.status
}

# Create the organization's Macie administrator account
resource "aws_macie2_organization_admin_account" "this" {
  # Setting this to your organization's mamagement account is not recommended following the principle of least provilege.  It is recommended that another account be created to manage your organization's Macie accounts.
  admin_account_id = data.aws_caller_identity.macie_administrator.account_id
}

data "aws_caller_identity" "macie_administrator" {
  provider = aws.macie_administrator
}
