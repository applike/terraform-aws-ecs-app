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
