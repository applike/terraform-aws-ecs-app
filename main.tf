module "container_definition" {
  count                        = length(var.schedule_expression) == 0 ? 1 : 0
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.57.0"
  container_name               = module.this.application
  container_image              = "${data.aws_ecr_repository.default.repository_url}:${data.aws_ecr_image.default.image_tag}"
  container_cpu                = data.aws_ssm_parameter.container_cpu.value
  container_memory_reservation = data.aws_ssm_parameter.container_memory_reservation.value
  working_directory            = var.working_directory
  map_environment              = var.environment_variables
  map_secrets                  = var.secrets
  ulimits                      = var.ulimits
  stop_timeout                 = var.stop_timeout
  docker_labels                = var.traefik_enabled ? local.docker_labels : var.docker_labels

  port_mappings = [
    {
      containerPort = var.port_gateway
      hostPort      = 0
      protocol      = "tcp"
    },
    {
      containerPort = var.port_metadata
      hostPort      = 0
      protocol      = "tcp"
    },
  ]

  healthcheck = {
    retries     = 3
    timeout     = 5
    interval    = 10
    startPeriod = 60

    command = [
      "CMD-SHELL",
      "wget --spider localhost:${var.port_health}/health || exit 1",
    ]
  }

  log_configuration = {
    logDriver = "awsfirelens"
    options   = {}
  }
}

module "container_definition_scheduled" {
  count                        = length(var.schedule_expression) > 0 ? 1 : 0
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.57.0"
  container_name               = module.this.application
  container_image              = "${data.aws_ecr_repository.default.repository_url}:${data.aws_ecr_image.default.image_tag}"
  container_cpu                = data.aws_ssm_parameter.container_cpu.value
  container_memory_reservation = data.aws_ssm_parameter.container_memory_reservation.value
  working_directory            = var.working_directory
  map_environment              = var.environment_variables
  map_secrets                  = var.secrets
  ulimits                      = var.ulimits
  stop_timeout                 = var.stop_timeout

  log_configuration = {
    logDriver = "awsfirelens"
    options   = {}
  }
}

module "container_definition_fluentbit" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.57.0"
  container_name               = "log_router"
  container_image              = "${data.aws_ecr_repository.log_router.repository_url}:${data.aws_ecr_image.log_router.image_tag}"
  container_memory_reservation = 4

  firelens_configuration = {
    type = "fluentbit"
    options = {
      config-file-type  = "file",
      config-file-value = "/fluent-bit/etc/extra.conf"
    }
  }

  log_configuration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = "firelens-container",
      awslogs-region        = "eu-central-1"
      awslogs-create-group  = "true",
      awslogs-stream-prefix = "firelens"
    }
  }

  map_environment = {
    ENVIRONMENT = module.this.environment
    PROJECT     = module.this.project
    FAMILY      = module.this.family
    APPLICATION = module.this.application
  }
}

module "ecs_service_task" {
  count                     = length(var.target_group_arn) == 0 && length(var.schedule_expression) == 0 ? 1 : 0
  source                    = "applike/ecs-service/aws"
  version                   = "1.3.1"
  context                   = module.this.context
  container_definition_json = "[${join("", module.container_definition.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn
  desired_count             = var.desired_count

  ordered_placement_strategy = [
    {
      type  = "spread"
      field = "instanceId"
  }]

  service_placement_constraints = [
    {
      type       = "memberOf"
      expression = "attribute:lifecycle == spot"
  }]
}

module "ecs_lb_service_task" {
  count                             = length(var.target_group_arn) > 0 ? 1 : 0
  source                            = "applike/ecs-service/aws"
  version                           = "1.3.1"
  context                           = module.this.context
  container_definition_json         = "[${join("", module.container_definition.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn                   = data.aws_ecs_cluster.default.id
  task_role_arn                     = data.aws_iam_role.default.arn
  task_exec_role_arn                = data.aws_iam_role.default.arn
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  service_registries                = var.service_registries

  ecs_load_balancers = [
    {
      target_group_arn = var.target_group_arn
      container_name   = module.this.application
      container_port   = var.port_gateway
  }]

  ordered_placement_strategy = [
    {
      type  = "spread"
      field = "instanceId"
  }]

  service_placement_constraints = [
    {
      type       = "memberOf"
      expression = "attribute:lifecycle == spot"
  }]
}

module "ecs_scheduled_task" {
  count                     = length(var.schedule_expression) > 0 ? 1 : 0
  source                    = "applike/ecs-scheduled-task/aws"
  version                   = "1.2.1"
  context                   = module.this.context
  container_definition_json = "[${join("", module.container_definition_scheduled.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn
  cloudwatch_event_role_arn = data.aws_iam_role.event.arn
  schedule_expression       = var.schedule_expression
  is_enabled                = var.is_enabled
  task_count                = var.task_count
}
