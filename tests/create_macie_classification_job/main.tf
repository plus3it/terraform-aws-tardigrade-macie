# Creates a Macie classification_job for this account.
# - Creates a Macie account for this AWS account
# - Creates Macie classification_jobs for this AWS account
module "classification_job" {
  source = "../../"

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"

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
    } /*,  The followijng classification job creates successfully, but cannot be destroyed with "terraform destroy" after the one-time job completes.  if you uncomment this code, then yu will need to remove the job form the state file.
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
    }*/
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

