# This file creates a standard Macie configuration in a single AWS account.  These include a Macie classification_job, findings_filter, and custom_data_identifier.  Macie configurations that require multiple AWS accounts are not included in this module, and the terraform code for those configurations has been implemented in seperate submodeles (see the modules section of this project).
#
# - Creates a Macie account for this AWS account
# - Creates one or more Macie classification_jobs for this account if the classification_job var is not empty.
# - Creates one or more Macie custom_data_identifiers for this account if the custom_data_identifier var is not empty.
# - Creates one or more Macie findings_filters for this account if the findings_filter var is not empty.
#
# Prerequisites:  None

# Creates a Macie account in this AWS account
resource "aws_macie2_account" "this" {
  finding_publishing_frequency = var.finding_publishing_frequency
  status                       = var.status
}

# Creates one or more Macie classification_jobs for this AWS account if the threclassification_job atintelset var is not empty.
resource "aws_macie2_classification_job" "this" {
  for_each = { for job in var.classification_job : job.name => job }

  dynamic "schedule_frequency" {
    for_each = each.value.schedule_frequency != null ? [each.value.schedule_frequency] : []

    content {
      daily_schedule   = schedule_frequency.value.daily_schedule
      weekly_schedule  = schedule_frequency.value.weekly_schedule
      monthly_schedule = schedule_frequency.value.monthly_schedule
    }
  }

  custom_data_identifier_ids = each.value.custom_data_identifier_ids
  sampling_percentage        = each.value.sampling_percentage
  name                       = each.value.name
  description                = each.value.description
  initial_run                = each.value.initial_run
  job_type                   = each.value.job_type
  job_status                 = each.value.job_status
  tags                       = each.value.tags

  s3_job_definition {

    dynamic "bucket_definitions" {
      for_each = each.value.s3_job_definition.bucket_definitions != null ? each.value.s3_job_definition.bucket_definitions : []

      content {
        account_id = bucket_definitions.value.account_id
        buckets    = bucket_definitions.value.buckets
      }
    }
    dynamic "scoping" {
      for_each = each.value.s3_job_definition.scoping != null ? [each.value.s3_job_definition.scoping] : []

      content {
        dynamic "excludes" {
          for_each = scoping.value.excludes != null ? [scoping.value.excludes] : []

          content {
            dynamic "and" {
              for_each = excludes.value.and != null ? excludes.value.and : []

              content {
                dynamic "simple_scope_term" {
                  for_each = and.value.simple_scope_term != null ? [and.value.simple_scope_term] : []

                  content {
                    comparator = simple_scope_term.value.comparator
                    values     = simple_scope_term.value.values
                    key        = simple_scope_term.value.key
                  }
                }
                dynamic "tag_scope_term" {
                  for_each = and.value.tag_scope_term != null ? [and.value.tag_scope_term] : []

                  content {
                    comparator = tag_scope_term.value.comparator
                    key        = tag_scope_term.value.key
                    target     = tag_scope_term.value.target

                    dynamic "tag_values" {
                      for_each = tag_scope_term.value.tag_values != null ? [tag_scope_term.value.tag_values] : []

                      content {
                        value = lookup(tag_values.value, "value", null)
                        key   = lookup(tag_values.value, "key", null)
                      }
                    }
                  }
                }
              }
            }
          }
        }
        dynamic "includes" {
          for_each = scoping.value.includes != null ? [scoping.value.includes] : []

          content {
            dynamic "and" {
              for_each = includes.value.and != null ? includes.value.and : []

              content {
                dynamic "simple_scope_term" {
                  for_each = and.value.simple_scope_term != null ? [and.value.simple_scope_term] : []

                  content {
                    comparator = simple_scope_term.value.comparator
                    values     = simple_scope_term.value.values
                    key        = simple_scope_term.value.key
                  }
                }
                dynamic "tag_scope_term" {
                  for_each = and.value.tag_scope_term != null ? [and.value.tag_scope_term] : []

                  content {
                    comparator = tag_scope_term.value.comparator
                    key        = tag_scope_term.value.key
                    target     = tag_scope_term.value.target

                    dynamic "tag_values" {
                      for_each = tag_scope_term.value.tag_values != null ? [tag_scope_term.value.tag_values] : []

                      content {
                        value = lookup(tag_values.value, "value", null)
                        key   = lookup(tag_values.value, "key", null)
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  depends_on = [aws_macie2_account.this]
}

# Creates one or more Macie custom_data_identifiers for this AWS account if the custom_data_identifier var is not empty.
resource "aws_macie2_custom_data_identifier" "this" {
  for_each = { for identifier in var.custom_data_identifier : identifier.name => identifier }

  regex                  = each.value.regex
  keywords               = each.value.keywords
  ignore_words           = each.value.ignore_words
  name                   = each.value.name
  name_prefix            = each.value.name_prefix
  description            = each.value.description
  maximum_match_distance = each.value.maximum_match_distance
  tags                   = each.value.tags

  depends_on = [aws_macie2_account.this]
}

# Creates one or more Macie findings_filters for this AWS account if the custom_data_identifier var is not empty.
resource "aws_macie2_findings_filter" "this" {
  for_each = { for filter in var.findings_filter : filter.name => filter }

  name        = each.value.name
  name_prefix = each.value.name_prefix
  description = each.value.description
  action      = each.value.action
  position    = each.value.position
  tags        = each.value.tags
  finding_criteria {
    dynamic "criterion" {
      for_each = each.value.criterion
      content {
        field          = criterion.value.field
        eq_exact_match = criterion.value.eq_exact_match
        eq             = criterion.value.eq
        neq            = criterion.value.neq
        lt             = criterion.value.lt
        lte            = criterion.value.lte
        gt             = criterion.value.gt
        gte            = criterion.value.gte
      }
    }
  }

  depends_on = [aws_macie2_account.this]
}
