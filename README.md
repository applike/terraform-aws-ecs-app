# Terraform Modules Template

[![tflint](https://github.com/applike/terraform-modules-template/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/applike/terraform-modules-template/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/applike/terraform-modules-template/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/applike/terraform-modules-template/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/applike/terraform-modules-template/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
[![release](https://github.com/applike/terraform-modules-template/workflows/release/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-modules-template/actions?query=workflow%3Arelease+event%3Apush+branch%3Amaster)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/applike/terraform-modules-template)
[![License](https://img.shields.io/github/license/applike/terraform-modules-template)](https://github.com/applike/terraform-modules-template/blob/master/LICENSE)

## Example
```hcl
module "example" {
  source = "applike/terraform-aws-module
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | Solution application, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| enable\_image\_tag | Set it to 'true' for parsing in a custom 'image\_tag' | `bool` | `false` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| environment\_variables | The environment variables to pass to the container. This is a list of maps. map\_environment overrides environment | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| family | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| image\_tag | The container image tag for the ECS task definition | `string` | `null` | no |
| project | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| secrets | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `null` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
