variable "finding_publishing_frequency" {
  description = "(Optional) Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN_MINUTES, ONE_HOUR or SIX_HOURS."
  type        = string
  default     = "SIX_HOURS"
  validation {
    condition     = var.finding_publishing_frequency != null ? contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.finding_publishing_frequency) : true
    error_message = "The aws_macie2_account finding_publishing_frequency value is not valid. Valid values: FIFTEEN_MINUTES, ONE_HOUR, or SIX_HOURS."
  }
}

variable "status" {
  description = "(Optional) Specifies the status for the account. To enable Amazon Macie and start all Macie activities for the account, set this value to ENABLED. Valid values are ENABLED or PAUSED."
  type        = string
  default     = "ENABLED"
  validation {
    condition     = var.status != null ? contains(["ENABLED", "PAUSED"], var.status) : true
    error_message = "The aws_macie2_account status value is not valid. Valid values: ENABLED, and PAUSED."
  }
}

variable "classification_jobs" {
  description = "Macie classification job"
  type = list(object({
    schedule_frequency = object({ # (Optional) The recurrence pattern for running the job. To run the job only once, set this to null and set the value for the job_type property to ONE_TIME. Only one of the following propperties can be set to a value and the other two must be set to null.
      daily_schedule   = bool
      weekly_schedule  = string # Valid values are "MONDAY" , "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", and "SUNDAY"
      monthly_schedule = number # Valid values are 1 - 31
    })
    custom_data_identifier_ids = list(string) # (Optional) The custom data identifiers to use for data analysis and classification.
    sampling_percentage        = number       # (Optional) The sampling depth, as a percentage, to apply when processing objects. This value determines the percentage of eligible objects that the job analyzes. If this value is less than 100, Amazon Macie selects the objects to analyze at random, up to the specified percentage, and analyzes all the data in those objects.
    name                       = string       # (Optional) A custom name for the job. The name can contain as many as 500 characters. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix.
    description                = string       # (Optional) A custom description of the job. The description can contain as many as 200 characters.
    initial_run                = string       # (Optional) Specifies whether to analyze all existing, eligible objects immediately after the job is created.
    job_type                   = string       # (Required) The schedule for running the job. Valid values are: ONE_TIME - Run the job only once. If you specify this value, don't specify a value for the schedule_frequency property. SCHEDULED - Run the job on a daily, weekly, or monthly basis. If you specify this value, use the schedule_frequency property to define the recurrence pattern for the job.
    job_status                 = string       # (Optional) The status for the job. Valid values are: CANCELLED, RUNNING and USER_PAUSED
    tags                       = map(string)  # (Optional) A map of key-value pairs that specifies the tags to associate with the job. A job can have a maximum of 50 tags. Each tag consists of a tag key and an associated tag value. The maximum length of a tag key is 128 characters. The maximum length of a tag value is 256 characters.
    s3_job_definition = object({              # (Required) S3 buckets that contain the objects to analyze, and the scope of that analysis.
      bucket_definitions = list(object({      # (Optional) An array of objects, one for each AWS account that owns buckets to analyze. Each object specifies the account ID for an account and one or more buckets to analyze for the account.
        account_id = string                   # (Required) The unique identifier for the AWS account that owns the buckets.
        buckets    = list(string)             # (Required) An array that lists the names of the buckets.
      }))
      scoping = object({    # (Optional) The property- and tag-based conditions that determine which objects to include or exclude from the analysis.
        excludes = object({ # (Optional) The property- or tag-based conditions that determine which objects to exclude from the analysis
          and = list(object({
            simple_scope_term = object({ # (Optional) A property-based condition that defines a property, operator, and one or more values for including or excluding an object from the job.
              comparator = string        # (Optional) The operator to use in a condition. Valid values are: EQ, GT, GTE, LT, LTE, NE, CONTAINS, STARTS_WITH.
              values     = list(string)  # (Optional) An array that lists the values to use in the condition.
              key        = string        # (Optional) The object property to use in the condition.  Valid values: OBJECT_EXTENSION, OBJECT_LAST_MODIFIED_DATE, OBJECT_SIZE, and OBJECT_KEY
            })
            tag_scope_term = object({  # (Optional) A tag-based condition that defines the operator and tag keys or tag key and value pairs for including or excluding an object from the job.
              comparator = string      # (Optional) The operator to use in the condition.
              tag_values = map(string) # (Optional) The tag keys or tag key and value pairs to use in the condition.  Example: tag_values = {value="value", key="key"}
              key        = string      # (Required) The tag key to use in the condition.  Possible values: "TAG"
              target     = string      # (Required) The type of object to apply the condition to.  Possible values: "S3_OBJECT"
            })
          }))
        })
        includes = object({ # (Optional) The property- or tag-based conditions that determine which objects to include in the analysis
          and = list(object({
            simple_scope_term = object({ # (Optional) A property-based condition that defines a property, operator, and one or more values for including or excluding an object from the job.
              comparator = string        # (Optional) The operator to use in a condition. Valid values are: EQ, GT, GTE, LT, LTE, NE, CONTAINS, STARTS_WITH.
              values     = list(string)  # (Optional) An array that lists the values to use in the condition.
              key        = string        # (Optional) The object property to use in the condition.  Valid values: OBJECT_EXTENSION, OBJECT_LAST_MODIFIED_DATE, OBJECT_SIZE, and OBJECT_KEY
            })
            tag_scope_term = object({  # (Optional) A tag-based condition that defines the operator and tag keys or tag key and value pairs for including or excluding an object from the job.
              comparator = string      # (Optional) The operator to use in the condition.
              tag_values = map(string) # (Optional) The tag keys or tag key and value pairs to use in the condition.  Example: tag_values = {value="value", key="key"}
              key        = string      # (Required) The tag key to use in the condition.  Possible values: "TAG"
              target     = string      # (Required) The type of object to apply the condition to.  Possible values: "S3_OBJECT"
            })
          }))
        })
      })
    })
  }))
  default = []
}

variable "custom_data_identifiers" {
  description = "AWS Macie Custom Data Identifier."
  type = list(object({
    regex                  = string       # (Optional) The regular expression (regex) that defines the pattern to match. The expression can contain as many as 512 characters.
    keywords               = list(string) # (Optional) An array that lists specific character sequences (keywords), one of which must be within proximity (maximum_match_distance) of the regular expression to match. The array can contain as many as 50 keywords. Each keyword can contain 3 - 90 characters. Keywords aren't case sensitive.
    ignore_words           = list(string) # (Optional) An array that lists specific character sequences (ignore words) to exclude from the results. If the text matched by the regular expression is the same as any string in this array, Amazon Macie ignores it. The array can contain as many as 10 ignore words. Each ignore word can contain 4 - 90 characters. Ignore words are case sensitive.
    name                   = string       # (Optional) A custom name for the custom data identifier. The name can contain as many as 128 characters. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix.
    name_prefix            = string       # (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name.
    description            = string       # (Optional) A custom description of the custom data identifier. The description can contain as many as 512 characters.
    maximum_match_distance = number       # (Optional) The maximum number of characters that can exist between text that matches the regex pattern and the character sequences specified by the keywords array. Macie includes or excludes a result based on the proximity of a keyword to text that matches the regex pattern. The distance can be 1 - 300 characters. The default value is 50.
    tags                   = map(string)  # (Optional) Key-value map of resource tags.
  }))
  default = []
}

variable "findings_filters" {
  description = " Amazon Macie Findings Filter."
  type = list(object({
    name        = string            # (Optional) A custom name for the filter. The name must contain at least 3 characters and can contain as many as 64 characters. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix.
    name_prefix = string            # (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name.
    description = string            # (Optional) A custom description of the filter. The description can contain as many as 512 characters.
    action      = string            # (Required) The action to perform on findings that meet the filter criteria (finding_criteria). Valid values are: ARCHIVE, suppress (automatically archive) the findings; and, NOOP, don't perform any action on the findings.
    position    = number            # (Optional) The position of the filter in the list of saved filters on the Amazon Macie console. This value also determines the order in which the filter is applied to findings, relative to other filters that are also applied to the findings.
    tags        = map(string)       # (Optional) - The tags that you want to add to the Filter resource. A tag consists of a key and a value.
    criterion = list(object({       # (Required) The criteria to use to filter findings.
      field          = string       # (Required) The name of the field to be evaluated.  Valid values: Account ID, Category, Created at, Finding ID, Finding type, Origin type, Region, Sample, Severity, Updated at, and many more.  See the AWS web console - Amazon Macie - Findings page for the complete list
      eq_exact_match = set(string)  # (Optional) The value for the property exclusively matches (equals an exact match for) all the specified values. If you specify multiple values, Amazon Macie uses AND logic to join the values.
      eq             = list(string) # (Optional) The value for the property matches (equals) the specified value. If you specify multiple values, Amazon Macie uses OR logic to join the values.
      neq            = list(string) # (Optional) The value for the property doesn't match (doesn't equal) the specified value. If you specify multiple values, Amazon Macie uses OR logic to join the values.
      lt             = string       # (Optional) The value for the property is less than the specified value.
      lte            = string       # (Optional) The value for the property is less than or equal to the specified value.
      gt             = string       # (Optional) The value for the property is greater than the specified value.
      gte            = string       # (Optional) The value for the property is greater than or equal to the specified value.
    }))
  }))
  default = []
}


