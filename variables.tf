variable "project" {
  type        = string
  default     = ""
  description = "Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT'"
}

variable "family" {
  type        = string
  default     = ""
  description = "Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "application" {
  type        = string
  default     = ""
  description = "Solution application, e.g. 'app' or 'jenkins'"
}

variable "environment_variables" {
  type        = map(string)
  description = "The environment variables to pass to the container. This is a map of string: {key: value}. map_environment overrides environment"
  default     = null
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secrets to pass to the container. This is a list of maps"
  default     = null
}

variable "image_tag" {
  type        = string
  description = "The container image tag for the ECS task definition"
  default     = ""
}

variable "enable_image_tag" {
  type        = bool
  description = "Set it to 'true' for parsing in a custom 'image_tag'"
  default     = false
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the Target Group to which to route traffic"
  default     = ""
}

variable "ulimits" {
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  default     = null
}

variable "stop_timeout" {
  type        = number
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own"
  default     = null
}

variable "schedule_expression" {
  type        = string
  default     = ""
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus."
}

variable "is_enabled" {
  type        = bool
  description = "Whether the rule should be enabled."
  default     = true
}

variable "task_count" {
  type        = number
  description = "The number of tasks to create based on the TaskDefinition."
  default     = null
}

variable "max_capacity" {
  type        = number
  default     = null
  description = "The max capacity of the scalable target"
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "The min capacity of the scalable target"
}

variable "target_tracking_configuration" {
  type = list(object({
    target_value       = number
    scale_in_cooldown  = number
    scale_out_cooldown = number
    predefined_metric_specification = list(object({
      predefined_metric_type = string
      resource_label         = string
    }))
  }))
  description = "A target tracking policy, requires policy_type = 'TargetTrackingScaling'"
  default     = []
}

variable "volumes" {
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))
  description = "Task volume definitions as list of configuration objects"
  default     = []
}

variable "ecs_load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    target_group_arn = string
  }))
  description = "A list of load balancer config objects for the ECS service; see `load_balancer` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html"
  default     = []
}