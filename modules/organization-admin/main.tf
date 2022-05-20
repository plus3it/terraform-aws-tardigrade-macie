# Creates a Macie org delegated administrator account in an AWS organization.  Once created, all AWS accounts added to the AWS organization will be enrolled in Macie and managed by the delegated Macie org administrator account
# - Create the organization's delegated Macie administrator account
#
# Prerequisites:  The AWS org must already exist

# Create the organization's delegated Macie administrator account
resource "aws_macie2_organization_admin_account" "this" {
  # Setting this to your organization's mamagement account is not recommended following the principle of least provilege.  It is recommended that another account be created to manage your organization's Macie accounts.
  admin_account_id = var.delegated_administrator_account_id
}
