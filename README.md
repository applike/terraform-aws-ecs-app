# terraform-aws-ecs-app

[![tflint](https://github.com/applike/terraform-aws-ecs-app/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-app/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/applike/terraform-aws-ecs-app/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-app/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![tfdoc](https://github.com/applike/terraform-aws-ecs-app/workflows/tfdoc/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-app/actions?query=workflow%3Atfdoc+event%3Apush+branch%3Amaster)
[![release](https://github.com/applike/terraform-aws-ecs-app/workflows/release/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-app/actions?query=workflow%3Arelease+event%3Apush+branch%3Amaster)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/applike/terraform-aws-ecs-app)
[![License](https://img.shields.io/github/license/applike/terraform-aws-ecs-app)](https://github.com/applike/terraform-aws-ecs-app/blob/master/LICENSE)

## Example
```hcl
module "example" {
  source  = "applike/ecs-app/aws"
  version = "X.X.X"
}
```
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| container_definition | cloudposse/ecs-container-definition/aws | 0.56.0 |
| container_definition_fluentbit | cloudposse/ecs-container-definition/aws | 0.56.0 |
| container_definition_scheduled | cloudposse/ecs-container-definition/aws | 0.56.0 |
| data_label | applike/label/aws | 1.1.0 |
| ecr_label | applike/label/aws | 1.1.0 |
| ecs_lb_service_task | applike/ecs-service/aws | 1.2.0 |
| ecs_scheduled_task | applike/ecs-scheduled-task/aws | 1.1.1 |
| ecs_service_task | applike/ecs-service/aws | 1.2.0 |
| locals_label | applike/label/aws | 1.1.0 |
| log_router_label | applike/label/aws | 1.1.0 |
| parameter_label | applike/label/aws | 1.1.0 |
| this | applike/label/aws | 1.1.0 |

## Resources

| Name |
|------|
| [aws_ecr_image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_image) |
| [aws_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) |
| [aws_ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) |
| [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| application | Solution application, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "application": null,<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "family": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "project": null,<br>  "regex_replace_chars": null,<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `project`, `environment`, `family`, `application` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| desired\_count | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| docker\_labels | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| environment\_variables | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| family | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| health\_check\_grace\_period\_seconds | Define how long ecs should wait to do the first health check | `number` | `5` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| image\_tag | The container image tag for the ECS task definition | `string` | `""` | no |
| is\_enabled | Whether the rule should be enabled. | `bool` | `true` | no |
| label\_key\_case | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["project", "environment", "family", "application", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| port\_gateway | Define the gateway port | `number` | `8088` | no |
| port\_health | Define the health port | `number` | `8090` | no |
| port\_metadata | Define the metadata port | `number` | `8070` | no |
| project | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `project`, `environment`, `family` and `application`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| schedule\_expression | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| secrets | The secrets variables to pass to the container. This is a map of string: {key: value}. map\_secrets overrides secrets | `map(string)` | `null` | no |
| service\_registries | The service discovery registries for the service. The maximum number of service\_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1 | <pre>list(object({<br>    registry_arn   = string<br>    port           = number<br>    container_name = string<br>    container_port = number<br>  }))</pre> | `[]` | no |
| stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| target\_group\_arn | The ARN of the Target Group to which to route traffic | `string` | `""` | no |
| task\_count | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| traefik\_domain | Define the traefik domain to use | `string` | `null` | no |
| traefik\_enabled | Set it to 'true' for enabling traefik | `bool` | `true` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
