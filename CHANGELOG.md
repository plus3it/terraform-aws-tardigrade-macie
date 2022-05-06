## terraform-aws-tardigrade-macie-member Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### 1.0.0

**Released**: 2022.05.06

**Commit Delta**: [Change from 0.0.1 release](https://github.com/plus3it/terraform-aws-tardigrade-macie-member/compare/0.0.0...1.0.0)

**Summary**:

*   Rewrite of module usinfg terraform Macie2.  This main module creates a standard Macie configuration in a single AWS account.  These include a Macie classification_job, findings_filter, and custom_data_identifier.  Macie configurations that require multiple AWS accounts are not included in this module, and the terraform code for those configurations has been implemented in seperate submodeles.  There are submodules for a Macie member and a Macie org admin (see the modules section of this project).  The main module performs the following tasks:

- Creates a Macie account for this AWS account
- Creates one or more Macie classification_jobs for this account if the classification_job var is not empty.
- Creates one or more Macie custom_data_identifiers for this account if the custom_data_identifier var is not empty.
- Creates one or more Macie findings_filters for this account if the findings_filter var is not empty.

### 0.0.1

**Released**: 2020.05.14

**Commit Delta**: [Change from 0.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-macie-member/compare/0.0.0...0.0.1)

**Summary**:

*   Rename module to more appropriately represent functionality

### 0.0.0

**Commit Delta**: N/A

**Released**: 2020.05.13

**Summary**:

*   Initial release!
