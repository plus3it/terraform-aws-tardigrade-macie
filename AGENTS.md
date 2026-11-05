# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module enables Amazon Macie in a single AWS account and can create Macie classification jobs, custom data identifiers, and findings filters in that account. The main inputs are `classification_jobs`, `custom_data_identifiers`, and `findings_filters`; each is an empty list by default, and `status` and `finding_publishing_frequency` set the account itself. The module outputs `account`, `classification_job`, `custom_data_identifier`, and `findings_filter`.

### Module-specific files

- `modules/member/` — Submodule that enables Macie in a member account, invites it from an administrator account (through the `aws.administrator` provider alias), and accepts the invitation; consumers call it directly, the root module does not
- `modules/organization-admin/` — Submodule that designates the delegated Macie administrator account for an AWS organization from `delegated_administrator_account_id`; consumers call it directly, the root module does not
