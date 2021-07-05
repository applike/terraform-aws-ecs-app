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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm-service-resources"></a> [alarm-service-resources](#module\_alarm-service-resources) | applike/alarm-service-resources/aws | 1.1.1 |
| <a name="module_container_definition"></a> [container\_definition](#module\_container\_definition) | cloudposse/ecs-container-definition/aws | 0.57.0 |
| <a name="module_container_definition_fluentbit"></a> [container\_definition\_fluentbit](#module\_container\_definition\_fluentbit) | cloudposse/ecs-container-definition/aws | 0.57.0 |
| <a name="module_container_definition_scheduled"></a> [container\_definition\_scheduled](#module\_container\_definition\_scheduled) | cloudposse/ecs-container-definition/aws | 0.57.0 |
| <a name="module_data_label"></a> [data\_label](#module\_data\_label) | applike/label/aws | 1.1.0 |
| <a name="module_ecr_label"></a> [ecr\_label](#module\_ecr\_label) | applike/label/aws | 1.1.0 |
| <a name="module_ecs_lb_service_task"></a> [ecs\_lb\_service\_task](#module\_ecs\_lb\_service\_task) | applike/ecs-service/aws | 1.3.1 |
| <a name="module_ecs_scheduled_task"></a> [ecs\_scheduled\_task](#module\_ecs\_scheduled\_task) | applike/ecs-scheduled-task/aws | 1.2.1 |
| <a name="module_ecs_service_task"></a> [ecs\_service\_task](#module\_ecs\_service\_task) | applike/ecs-service/aws | 1.3.1 |
| <a name="module_locals_label"></a> [locals\_label](#module\_locals\_label) | applike/label/aws | 1.1.0 |
| <a name="module_log_router_label"></a> [log\_router\_label](#module\_log\_router\_label) | applike/label/aws | 1.1.0 |
| <a name="module_parameter_label"></a> [parameter\_label](#module\_parameter\_label) | applike/label/aws | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | applike/label/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_image.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_image) | data source |
| [aws_ecr_image.log_router](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_image) | data source |
| [aws_ecr_repository.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_ecr_repository.log_router](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_ecs_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_iam_role.event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_ssm_parameter.container_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.container_memory_reservation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.container_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | Solution application, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "application": null,<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "family": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "project": null,<br>  "regex_replace_chars": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `project`, `environment`, `family`, `application` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_docker_labels"></a> [docker\_labels](#input\_docker\_labels) | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| <a name="input_family"></a> [family](#input\_family) | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Define how long ecs should wait to do the first health check | `number` | `5` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The container image tag for the ECS task definition | `string` | `""` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether the rule should be enabled. | `bool` | `true` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["project", "environment", "family", "application", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_port_gateway"></a> [port\_gateway](#input\_port\_gateway) | Define the gateway port | `number` | `8088` | no |
| <a name="input_port_health"></a> [port\_health](#input\_port\_health) | Define the health port | `number` | `8090` | no |
| <a name="input_port_metadata"></a> [port\_metadata](#input\_port\_metadata) | Define the metadata port | `number` | `8070` | no |
| <a name="input_project"></a> [project](#input\_project) | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Mode of propagating tags across services, task definitions and tasks. One of TASK\_DEFINITION or SERVICE. Set to NONE to prevent tags from being propagated. | `string` | `"NONE"` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `project`, `environment`, `family` and `application`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_resource_alarms_average_cpu_threshold"></a> [resource\_alarms\_average\_cpu\_threshold](#input\_resource\_alarms\_average\_cpu\_threshold) | Upper threshold for average CPU utilization. Keep some headroom for covering bursts. | `number` | `100` | no |
| <a name="input_resource_alarms_average_datapoints_to_alarm"></a> [resource\_alarms\_average\_datapoints\_to\_alarm](#input\_resource\_alarms\_average\_datapoints\_to\_alarm) | Number of threshold breaches required for triggering alarms based on averaging their metric | `number` | `3` | no |
| <a name="input_resource_alarms_average_evaluation_periods"></a> [resource\_alarms\_average\_evaluation\_periods](#input\_resource\_alarms\_average\_evaluation\_periods) | Number of periods taking into account for alarms based on averaging their metric | `number` | `3` | no |
| <a name="input_resource_alarms_average_memory_threshold"></a> [resource\_alarms\_average\_memory\_threshold](#input\_resource\_alarms\_average\_memory\_threshold) | Upper threshold for average memory utilization. Keep some headroom for covering bursts. | `number` | `100` | no |
| <a name="input_resource_alarms_average_period"></a> [resource\_alarms\_average\_period](#input\_resource\_alarms\_average\_period) | Period for alarms based on averaging their metric | `number` | `300` | no |
| <a name="input_resource_alarms_enabled"></a> [resource\_alarms\_enabled](#input\_resource\_alarms\_enabled) | Defines if resource alarms should be created | `bool` | `null` | no |
| <a name="input_resource_alarms_maximum_cpu_threshold"></a> [resource\_alarms\_maximum\_cpu\_threshold](#input\_resource\_alarms\_maximum\_cpu\_threshold) | Upper threshold for maximum CPU utilization | `number` | `150` | no |
| <a name="input_resource_alarms_maximum_datapoints_to_alarm"></a> [resource\_alarms\_maximum\_datapoints\_to\_alarm](#input\_resource\_alarms\_maximum\_datapoints\_to\_alarm) | Number of threshold breaches required for triggering alarms based on maximising their metric | `number` | `3` | no |
| <a name="input_resource_alarms_maximum_evaluation_periods"></a> [resource\_alarms\_maximum\_evaluation\_periods](#input\_resource\_alarms\_maximum\_evaluation\_periods) | Number of periods taking into account for alarms based on maximising their metric | `number` | `10` | no |
| <a name="input_resource_alarms_maximum_memory_threshold"></a> [resource\_alarms\_maximum\_memory\_threshold](#input\_resource\_alarms\_maximum\_memory\_threshold) | Upper threshold for maximum memory utilization | `number` | `150` | no |
| <a name="input_resource_alarms_maximum_period"></a> [resource\_alarms\_maximum\_period](#input\_resource\_alarms\_maximum\_period) | Period for alarms based on maximising their metric | `number` | `60` | no |
| <a name="input_resource_alarms_treat_missing_data"></a> [resource\_alarms\_treat\_missing\_data](#input\_resource\_alarms\_treat\_missing\_data) | How to treat missing data, defaults to 'breaching' | `string` | `"breaching"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets variables to pass to the container. This is a map of string: {key: value}. map\_secrets overrides secrets | `map(string)` | `null` | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | The service discovery registries for the service. The maximum number of service\_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1 | <pre>list(object({<br>    registry_arn   = string<br>    port           = number<br>    container_name = string<br>    container_port = number<br>  }))</pre> | `[]` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the Target Group to which to route traffic | `string` | `""` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| <a name="input_traefik_domain"></a> [traefik\_domain](#input\_traefik\_domain) | Define the traefik domain to use | `string` | `null` | no |
| <a name="input_traefik_enabled"></a> [traefik\_enabled](#input\_traefik\_enabled) | Set it to 'true' for enabling traefik | `bool` | `true` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory to run commands inside the container | `string` | `"/app"` | no |

## Outputs

No outputs.

<!--- END_TF_DOCS --->
