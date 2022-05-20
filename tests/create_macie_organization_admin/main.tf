# AWS provider account for the AWS organization
provider "aws" {
  region  = "us-east-1"
  profile = "aws" # Profile must exist in your .aws/config
}

# AWS provider account for the Macie org administrator account
provider "aws" {
  region  = "us-east-1"
  alias   = "macie_administrator"
  profile = "awsalternate" # Profile must exist in your .aws/config
}

# Create AWS Organization in the this account
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = ["macie2.amazonaws.com"]
  feature_set                   = "ALL"
}

# Create Macie account for the organization's GuardDuty administrator account
resource "aws_macie2_account" "macie_administrator" {
  provider                     = aws.macie_administrator
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"
}

data "aws_caller_identity" "macie_administrator" {
  provider = aws.macie_administrator
}

# Create a Macie org administrator account in the AWS organization
# - Creates the organization's delegated Macie administrator account
#
# Prerequisites:  The AWS org must already exist
module "macie_org_admin_account" {
  source = "../../modules/organization-admin"

  delegated_administrator_account_id = data.aws_caller_identity.macie_administrator.account_id

  depends_on = [aws_organizations_organization.this]
}
