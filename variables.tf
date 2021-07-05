variable "environment_variables" {
  type        = map(string)
  description = "The environment variables to pass to the container. This is a map of string: {key: value}. map_environment overrides environment"
  default     = null
}

variable "secrets" {
  type        = map(string)
  description = "The secrets variables to pass to the container. This is a map of string: {key: value}. map_secrets overrides secrets"
  default     = null
}

variable "image_tag" {
  type        = string
  description = "The container image tag for the ECS task definition"
  default     = ""
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the Target Group to which to route traffic"
  default     = ""
}

variable "ulimits" {
  type        = list(object({
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

variable "docker_labels" {
  type        = map(string)
  description = "The configuration options to send to the `docker_labels`"
  default     = null
}

variable "traefik_enabled" {
  type        = bool
  description = "Set it to 'true' for enabling traefik"
  default     = true
}

variable "traefik_domain" {
  type        = string
  description = "Define the traefik domain to use"
  default     = null
}

variable "port_metadata" {
  type        = number
  description = "Define the metadata port"
  default     = 8070
}

variable "port_gateway" {
  type        = number
  description = "Define the gateway port"
  default     = 8088
}

variable "port_health" {
  type        = number
  description = "Define the health port"
  default     = 8090
}

variable "health_check_grace_period_seconds" {
  type        = number
  default     = 5
  description = "Define how long ecs should wait to do the first health check"
}

variable "desired_count" {
  type        = number
  description = "The number of instances of the task definition to place and keep running"
  default     = 1
}

variable "service_registries" {
  type        = list(object({
    registry_arn   = string
    port           = number
    container_name = string
    container_port = number
  }))
  description = "The service discovery registries for the service. The maximum number of service_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1"
  default     = []
}

variable "resource_alarms_enabled" {
  type        = bool
  default     = null
  description = "Defines if resource alarms should be created"
}

variable "resource_alarms_treat_missing_data" {
  type        = string
  default     = "breaching"
  description = "How to treat missing data, defaults to 'breaching'"
}

variable "resource_alarms_average_period" {
  type        = number
  default     = 300
  description = "Period for alarms based on averaging their metric"
}

variable "resource_alarms_average_evaluation_periods" {
  type        = number
  default     = 3
  description = "Number of periods taking into account for alarms based on averaging their metric"
}

variable "resource_alarms_average_datapoints_to_alarm" {
  type        = number
  default     = 3
  description = "Number of threshold breaches required for triggering alarms based on averaging their metric"
}

variable "resource_alarms_average_cpu_threshold" {
  type        = number
  default     = 100
  description = "Upper threshold for average CPU utilization. Keep some headroom for covering bursts."
}

variable "resource_alarms_average_memory_threshold" {
  type        = number
  default     = 100
  description = "Upper threshold for average memory utilization. Keep some headroom for covering bursts."
}

variable "resource_alarms_maximum_period" {
  type        = number
  default     = 60
  description = "Period for alarms based on maximising their metric"
}

variable "resource_alarms_maximum_evaluation_periods" {
  type        = number
  default     = 10
  description = "Number of periods taking into account for alarms based on maximising their metric"
}

variable "resource_alarms_maximum_datapoints_to_alarm" {
  type        = number
  default     = 3
  description = "Number of threshold breaches required for triggering alarms based on maximising their metric"
}

variable "resource_alarms_maximum_cpu_threshold" {
  type        = number
  default     = 150
  description = "Upper threshold for maximum CPU utilization"
}

variable "resource_alarms_maximum_memory_threshold" {
  type        = number
  default     = 150
  description = "Upper threshold for maximum memory utilization"
}

variable "propagate_tags" {
  type        = string
  default     = "NONE"
  description = "Mode of propagating tags across services, task definitions and tasks. One of TASK_DEFINITION or SERVICE. Set to NONE to prevent tags from being propagated."
}

variable "working_directory" {
  type        = string
  description = "The working directory to run commands inside the container"
  default     = "/app"
}