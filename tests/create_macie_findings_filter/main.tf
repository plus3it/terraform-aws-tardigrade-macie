# Creates a Macie findings_filter for this account.
# - Creates a Macie account for this AWS account
# - Creates a Macie findings_filter for this AWS account
module "findings_filter" {
  source = "../../"

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"

  findings_filter = [
    {
      name        = "Filter1"
      name_prefix = null
      description = "My Filter 1"
      position    = 1
      action      = "ARCHIVE"
      tags = {
        environment = "testing"
      }
      criterion = [
        {
          field          = "region"
          eq_exact_match = null
          eq             = ["us-east-1"]
          neq            = null
          lt             = null
          lte            = null
          gt             = null
          gte            = null
        },
        {
          field          = "category"
          eq_exact_match = null
          eq             = ["Policy"]
          neq            = ["Classification"]
          lt             = null
          lte            = null
          gt             = null
          gte            = null
        },
        {
          field          = "sample"
          eq_exact_match = null
          eq             = ["true"]
          neq            = null
          lt             = null
          lte            = null
          gt             = null
          gte            = null
        }
      ]
    },
    {
      name        = "Filter2"
      name_prefix = null
      description = "My Filter 2"
      position    = 2
      action      = "ARCHIVE"
      tags = {
        environment = "testing"
      }
      criterion = [
        {
          field          = "accountId"
          eq_exact_match = null
          eq             = ["123418158163", "123458158163"]
          neq            = ["223418158163", "223458158163"]
          lt             = null
          lte            = null
          gt             = null
          gte            = null
        },
        {
          field          = "resourcesAffected.s3Bucket.defaultServerSideEncryption.encryptionType"
          eq_exact_match = null
          eq             = ["None"]
          neq            = null
          lt             = null
          lte            = null
          gt             = null
          gte            = null
        },
      ]
    }
  ]
}
