module "label" {
  source      = "applike/label/aws"
  version     = "1.0.2"
  project     = var.project
  application = var.application
  family      = var.family
  environment = var.environment
  tags = {
    "ApplicationType" = var.application_type
  }
}

module "ssm_label" {
  source    = "applike/label/aws"
  version   = "1.0.2"
  context   = module.label.context
  delimiter = "/"
}

module "container_definition" {
  count                        = length(var.schedule_expression) == 0 ? 1 : 0
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.46.1"
  container_name               = module.label.application
  container_image              = "${data.aws_ecr_repository.default.repository_url}:${data.aws_ecr_image.default.image_tag}"
  container_cpu                = data.aws_ssm_parameter.container_cpu.value
  container_memory_reservation = data.aws_ssm_parameter.container_memory_reservation.value
  working_directory            = "/app"
  map_environment              = var.environment_variables
  secrets                      = var.secrets
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
  version                      = "0.46.1"
  container_name               = module.label.application
  container_image              = "${data.aws_ecr_repository.default.repository_url}:${data.aws_ecr_image.default.image_tag}"
  container_cpu                = data.aws_ssm_parameter.container_cpu.value
  container_memory_reservation = data.aws_ssm_parameter.container_memory_reservation.value
  working_directory            = "/app"
  map_environment              = var.environment_variables
  secrets                      = var.secrets
  ulimits                      = var.ulimits
  stop_timeout                 = var.stop_timeout

  log_configuration = {
    logDriver = "awsfirelens"
    options   = {}
  }
}

module "container_definition_fluentbit" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.46.1"
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
    ENVIRONMENT = module.label.environment
    PROJECT     = module.label.project
    FAMILY      = module.label.family
    APPLICATION = module.label.application
  }
}

module "ecs_service_task" {
  count                     = length(var.target_group_arn) == 0 && length(var.schedule_expression) == 0 ? 1 : 0
  source                    = "applike/ecs-service/aws"
  version                   = "1.1.4"
  project                   = module.label.project
  environment               = module.label.environment
  family                    = module.label.family
  application               = module.label.application
  container_definition_json = "[${join("", module.container_definition.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  tags                      = module.label.tags
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn

  ordered_placement_strategy = [{
    type  = "spread"
    field = "instanceId"
  }]

  service_placement_constraints = [{
    type       = "memberOf"
    expression = "attribute:lifecycle == spot"
  }]
}

module "ecs_lb_service_task" {
  count                     = length(var.target_group_arn) > 0 ? 1 : 0
  source                    = "applike/ecs-service/aws"
  version                   = "1.1.4"
  project                   = module.label.project
  environment               = module.label.environment
  family                    = module.label.family
  application               = module.label.application
  container_definition_json = "[${join("", module.container_definition.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  tags                      = module.label.tags
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn
  enable_lb                 = true

  ecs_load_balancers = [{
    target_group_arn = var.target_group_arn
    container_name   = module.label.application
    container_port   = var.port_gateway
  }]

  ordered_placement_strategy = [{
    type  = "spread"
    field = "instanceId"
  }]

  service_placement_constraints = [{
    type       = "memberOf"
    expression = "attribute:lifecycle == spot"
  }]
}

module "ecs_scheduled_task" {
  count                     = length(var.schedule_expression) > 0 ? 1 : 0
  source                    = "applike/ecs-scheduled-task/aws"
  version                   = "1.0.5"
  project                   = module.label.project
  environment               = module.label.environment
  family                    = module.label.family
  application               = module.label.application
  container_definition_json = "[${join("", module.container_definition_scheduled.*.json_map_encoded)},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  tags                      = module.label.tags
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn
  cloudwatch_event_role_arn = data.aws_iam_role.event.arn
  schedule_expression       = var.schedule_expression
  is_enabled                = var.is_enabled
  task_count                = var.task_count
}