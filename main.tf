module "label" {
  source      = "applike/label/aws"
  version     = "1.0.1"
  project     = var.project
  application = var.application
  family      = var.family
  environment = var.environment
}

module "ssm_label" {
  source    = "applike/label/aws"
  version   = "1.0.1"
  context   = module.label.context
  delimiter = "/"
}

module "container_definition" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.46.1"
  container_name               = module.label.application
  container_image              = "${data.aws_ecr_repository.default.repository_url}:${data.aws_ecr_image.default.image_tag}"
  container_cpu                = data.aws_ssm_parameter.container_cpu.value
  container_memory_reservation = data.aws_ssm_parameter.container_memory_reservation.value
  working_directory            = "/app"
  environment                  = concat([], var.environment_variables)

  port_mappings = [
    {
      containerPort = 8088
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
      "wget --spider localhost:8090/health || exit 1",
    ]
  }

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

  environment = [
    {
      name  = "ENVIRONMENT"
      value = module.label.environment
    },
    {
      name  = "PROJECT"
      value = module.label.project
    },
    {
      name  = "FAMILY"
      value = module.label.family
    },
    {
      name  = "APPLICATION"
      value = module.label.application
    },
  ]
}

module "ecs_service_task" {
  enabled                   = var.enable_lb == false ? true : false
  source                    = "applike/ecs-service/aws"
  version                   = "1.1.2"
  project                   = module.label.project
  environment               = module.label.environment
  family                    = module.label.family
  application               = module.label.application
  container_definition_json = "[${module.container_definition.json_map_encoded},${module.container_definition_fluentbit.json_map_encoded}]"
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
  enabled                   = var.enable_lb
  source                    = "applike/ecs-service/aws"
  version                   = "1.1.2"
  project                   = module.label.project
  environment               = module.label.environment
  family                    = module.label.family
  application               = module.label.application
  container_definition_json = "[${module.container_definition.json_map_encoded},${module.container_definition_fluentbit.json_map_encoded}]"
  ecs_cluster_arn           = data.aws_ecs_cluster.default.id
  tags                      = module.label.tags
  task_role_arn             = data.aws_iam_role.default.arn
  task_exec_role_arn        = data.aws_iam_role.default.arn
  enable_lb                 = true

  ecs_load_balancers = [{
    target_group_arn = length(var.target_group_arn) > 0 ? var.target_group_arn : data.aws_lb_target_group.default.*.arn
    container_name   = module.label.application
    container_port   = 8088
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
