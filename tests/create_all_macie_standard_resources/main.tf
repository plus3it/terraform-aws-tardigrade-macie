# Creates all Macie standard resources for this account.
# - Creates a Macie account for this AWS account
# - Creates two Macie filters for this account
# - Creates two Macie custom_data_identifiers for this account
# - Creates Macie classification_jobs for this account
module "macie_standard_resources" {
  source = "../../"

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"

  custom_data_identifier = [
    {
      name                   = "DataIdentifier1"
      name_prefix            = null
      description            = "My Data Identifier 1"
      position               = 1
      regex                  = "v[i!1][a@]gr[a@]"
      keywords               = ["key1", "key2"]
      ignore_words           = ["key3", "key4"]
      maximum_match_distance = 1
      tags = {
        environment = "development"
      }
    },
    {
      name                   = "DataIdentifier2"
      name_prefix            = null
      description            = "My Data Identifier 2"
      position               = 1
      regex                  = "(?i)(\\W|^)(baloney|darn|drat|fooey|gosh\\sdarnit|heck)(\\W|$)"
      keywords               = ["key5", "key6"]
      ignore_words           = ["key7", "key8"]
      maximum_match_distance = 1
      tags = {
        environment = "testing"
      }
    }
  ]

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

  classification_job = [
    {
      name        = "classificationJob1"
      description = "Classification Job 1"
      schedule_frequency = {
        daily_schedule   = null
        weekly_schedule  = null
        monthly_schedule = 1
      }
      custom_data_identifier_ids = null
      sampling_percentage        = 100
      initial_run                = "true"
      job_type                   = "SCHEDULED"
      job_status                 = "RUNNING"
      tags = {
        environment = "testing"
      }
      s3_job_definition = {
        bucket_definitions = [
          {
            account_id = data.aws_caller_identity.current.account_id
            buckets    = [aws_s3_bucket.bucket.id]
          }
        ]

        scoping = {
          excludes = {
            and = [
              {
                simple_scope_term = {
                  comparator = "STARTS_WITH"
                  values     = ["mykey"]
                  key        = "OBJECT_KEY"
                }
                tag_scope_term = null
              }
            ]
          }
          includes = null
        }
      }
    },
    {
      name        = "classificationJob2"
      description = "Classification Job 2"
      schedule_frequency = {
        daily_schedule   = null
        weekly_schedule  = "MONDAY"
        monthly_schedule = null
      }
      custom_data_identifier_ids = null
      sampling_percentage        = 80
      initial_run                = "true"
      job_type                   = "SCHEDULED"
      job_status                 = "RUNNING"
      tags = {
        environment = "development"
      }
      s3_job_definition = {
        bucket_definitions = [
          {
            account_id = data.aws_caller_identity.current.account_id
            buckets    = [aws_s3_bucket.bucket.id]
          }
        ]

        scoping = {
          includes = {
            and = [
              {
                simple_scope_term = null
                tag_scope_term = {
                  comparator = "EQ"
                  tag_values = { value = "development", key = "key" }
                  key        = "TAG"
                  target     = "S3_OBJECT"
                }
              }
            ]
          }
          excludes = null
        }
      }
    } /*,  The followijng classification job creates successfully, but cannot be destroyed with "terraform destroy" after the one-time job completes.  if you uncomment this code, then yu will need to remove the job form the state file.,
    {
      name                       = "classificationJob3"
      description                = "Classification Job 3"
      schedule_frequency         = null
      custom_data_identifier_ids = null
      sampling_percentage        = 80
      initial_run                = "true"
      job_type                   = "ONE_TIME"
      job_status                 = "RUNNING"
      tags = {
        environment = "development"
      }
      s3_job_definition = {
        bucket_definitions = [
          {
            account_id = data.aws_caller_identity.current.account_id
            buckets    = [aws_s3_bucket.bucket.id]
          }
        ]

        scoping = {
          includes = null
          excludes = {
            and = [
              {
                simple_scope_term = {
                  comparator = "EQ"
                  values     = [".sh", ".exe"]
                  key        = "OBJECT_EXTENSION"
                }
                tag_scope_term = null
              }
            ]
          }
        }
      }
    } */
  ]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "random_id" "name" {
  byte_length = 6
  prefix      = "tardigrade-s3-bucket-"
}

resource "aws_s3_bucket" "bucket" {
  bucket        = random_id.name.hex
  force_destroy = true
  tags = {
    environment = "testing"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}
