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
| container_definition | cloudposse/ecs-container-definition/aws | 0.46.1 |
| container_definition_fluentbit | cloudposse/ecs-container-definition/aws | 0.46.1 |
| container_definition_scheduled | cloudposse/ecs-container-definition/aws | 0.46.1 |
| data_label | applike/label/aws | 1.0.2 |
| ecr_label | applike/label/aws | 1.0.2 |
| ecs_lb_service_task | applike/ecs-service/aws | 1.1.4 |
| ecs_scheduled_task | applike/ecs-scheduled-task/aws | 1.0.5 |
| ecs_service_task | applike/ecs-service/aws | 1.1.4 |
| label | applike/label/aws | 1.0.2 |
| locals_label | applike/label/aws | 1.0.2 |
| log_router_label | applike/label/aws | 1.0.2 |
| parameter_label | applike/label/aws | 1.0.2 |
| ssm_label | applike/label/aws | 1.0.2 |

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
| application | Solution application, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| application\_type | Type of the application, e.g. 'consumer', 'gateway' or 'redis' | `string` | n/a | yes |
| desired\_count | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| docker\_labels | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| enable\_image\_tag | Set it to 'true' for parsing in a custom 'image\_tag' | `bool` | `false` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `""` | no |
| environment\_variables | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| family | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `""` | no |
| health\_check\_grace\_period\_seconds | Define how long ecs should wait to do the first health check | `number` | `5` | no |
| image\_tag | The container image tag for the ECS task definition | `string` | `""` | no |
| is\_enabled | Whether the rule should be enabled. | `bool` | `true` | no |
| port\_gateway | Define the gateway port | `number` | `8088` | no |
| port\_health | Define the health port | `number` | `8090` | no |
| port\_metadata | Define the metadata port | `number` | `8070` | no |
| project | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| schedule\_expression | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| secrets | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `null` | no |
| stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| target\_group\_arn | The ARN of the Target Group to which to route traffic | `string` | `""` | no |
| task\_count | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| traefik\_domain | Define the traefik domain to use | `string` | `null` | no |
| traefik\_enabled | Set it to 'true' for enabling traefik | `bool` | `true` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
