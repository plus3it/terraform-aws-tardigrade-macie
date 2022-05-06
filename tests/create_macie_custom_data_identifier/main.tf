# Creates a Macie custom_data_identifier for this account.
# - Creates a Macie account for this AWS account
# - Creates a Macie custom_data_identifier for this AWS account
module "custom_data_identifier" {
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
}
